package com.statuses.statuses

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Environment
import androidx.core.content.FileProvider
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.statuses.statuses/saf"
    private val SAF_REQUEST_CODE = 42
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {

                    "openDocumentTree" -> {
                        pendingResult = result
                        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
                            addFlags(
                                Intent.FLAG_GRANT_READ_URI_PERMISSION or
                                Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION
                            )
                        }
                        startActivityForResult(intent, SAF_REQUEST_CODE)
                    }

                    "listFiles" -> {
                        val uriString = call.argument<String>("uri")
                        if (uriString == null) {
                            result.error("INVALID_ARGS", "Se requiere el argumento 'uri'", null)
                            return@setMethodCallHandler
                        }
                        try {
                            val uri = Uri.parse(uriString)
                            val docFile = DocumentFile.fromTreeUri(this, uri)
                            val files = docFile?.listFiles()
                                ?.filter { it.isFile }
                                ?.map { file ->
                                    mapOf(
                                        "uri" to file.uri.toString(),
                                        "name" to (file.name ?: ""),
                                        "size" to file.length(),
                                        "lastModified" to file.lastModified(),
                                        "type" to (file.type ?: ""),
                                    )
                                } ?: emptyList()
                            result.success(files)
                        } catch (e: Exception) {
                            result.error("SAF_ERROR", e.message, null)
                        }
                    }

                    "copyFileToCache" -> {
                        val uriString = call.argument<String>("uri")
                        val destPath = call.argument<String>("destPath")
                        if (uriString == null || destPath == null) {
                            result.error("INVALID_ARGS", "Se requieren 'uri' y 'destPath'", null)
                            return@setMethodCallHandler
                        }
                        try {
                            val uri = Uri.parse(uriString)
                            contentResolver.openInputStream(uri)?.use { input ->
                                File(destPath).outputStream().use { output ->
                                    input.copyTo(output)
                                }
                            }
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("SAF_ERROR", e.message, null)
                        }
                    }

                    "getPersistedPermissions" -> {
                        val perms = contentResolver.persistedUriPermissions.map {
                            mapOf(
                                "uri" to it.uri.toString(),
                                "isRead" to it.isReadPermission,
                                "isWrite" to it.isWritePermission,
                            )
                        }
                        result.success(perms)
                    }

                    "releasePermission" -> {
                        val uriString = call.argument<String>("uri")
                        if (uriString == null) {
                            result.error("INVALID_ARGS", "Se requiere el argumento 'uri'", null)
                            return@setMethodCallHandler
                        }
                        try {
                            val uri = Uri.parse(uriString)
                            contentResolver.releasePersistableUriPermission(
                                uri,
                                Intent.FLAG_GRANT_READ_URI_PERMISSION
                            )
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("SAF_ERROR", e.message, null)
                        }
                    }

                    "getPublicPicturesPath" -> {
                        val dir = Environment.getExternalStoragePublicDirectory(
                            Environment.DIRECTORY_PICTURES
                        )
                        result.success(dir.absolutePath)
                    }

                    "shareToWhatsAppStatus" -> {
                        val filePath = call.argument<String>("filePath")
                        val mimeType = call.argument<String>("mimeType") ?: "image/*"
                        if (filePath == null) {
                            result.error("INVALID_ARGS", "Se requiere 'filePath'", null)
                            return@setMethodCallHandler
                        }
                        try {
                            val file = File(filePath)
                            if (!file.exists()) {
                                result.error("FILE_NOT_FOUND", "El archivo no existe", null)
                                return@setMethodCallHandler
                            }
                            val uri = FileProvider.getUriForFile(
                                this,
                                "$packageName.fileprovider",
                                file
                            )
                            val intent = Intent(Intent.ACTION_SEND).apply {
                                type = mimeType
                                putExtra(Intent.EXTRA_STREAM, uri)
                                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                                setPackage("com.whatsapp")
                            }
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            try {
                                val intent = Intent(Intent.ACTION_SEND).apply {
                                    type = mimeType
                                    putExtra(Intent.EXTRA_STREAM, Uri.fromFile(File(filePath)))
                                    addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                                }
                                startActivity(Intent.createChooser(intent, "Compartir con WhatsApp"))
                                result.success(true)
                            } catch (e2: Exception) {
                                result.error("WHATSAPP_ERROR", e2.message, null)
                            }
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == SAF_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK && data?.data != null) {
                val uri = data.data!!
                contentResolver.takePersistableUriPermission(
                    uri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION
                )
                pendingResult?.success(uri.toString())
            } else {
                pendingResult?.success(null)
            }
            pendingResult = null
        }
    }
}
