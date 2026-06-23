///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$es app = _Translations$app$es._(_root);
	@override late final _Translations$filter$es filter = _Translations$filter$es._(_root);
	@override late final _Translations$nav$es nav = _Translations$nav$es._(_root);
	@override late final _Translations$detail$es detail = _Translations$detail$es._(_root);
	@override late final _Translations$saved$es saved = _Translations$saved$es._(_root);
	@override late final _Translations$permission$es permission = _Translations$permission$es._(_root);
	@override late final _Translations$empty$es empty = _Translations$empty$es._(_root);
	@override late final _Translations$date$es date = _Translations$date$es._(_root);
	@override late final _Translations$settings$es settings = _Translations$settings$es._(_root);
	@override late final _Translations$help$es help = _Translations$help$es._(_root);
}

// Path: app
class _Translations$app$es extends Translations$app$en {
	_Translations$app$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statuses';
}

// Path: filter
class _Translations$filter$es extends Translations$filter$en {
	_Translations$filter$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todo';
	@override String get photos => 'Fotos';
	@override String get videos => 'Videos';
}

// Path: nav
class _Translations$nav$es extends Translations$nav$en {
	_Translations$nav$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get statuses => 'Historias';
	@override String get saved => 'Guardados';
}

// Path: detail
class _Translations$detail$es extends Translations$detail$en {
	_Translations$detail$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get download => 'Descargar';
	@override String get share => 'Compartir';
	@override String get info => 'Información';
	@override String get close => 'Cerrar';
	@override String get file_info => 'Información del archivo';
	@override String get name => 'Nombre';
	@override String get size => 'Tamaño';
	@override String get type => 'Tipo';
	@override String get date => 'Fecha';
	@override String get file_not_found => 'Archivo no encontrado';
	@override String get unable_to_load_image => 'No se pudo cargar la imagen';
	@override String get loading_video => 'Cargando video...';
	@override String get unsupported_file_type => 'Tipo de archivo no soportado';
	@override String get saved_successfully => 'Archivo guardado correctamente';
	@override String get video_badge => 'VIDEO';
}

// Path: saved
class _Translations$saved$es extends Translations$saved$en {
	_Translations$saved$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get empty_title => 'Sin historias guardadas';
	@override String get empty_subtitle => 'Las historias que descargues aparecerán aquí.';
	@override String get empty_filtered_title => 'Sin resultados';
	@override String get empty_filtered_subtitle => 'No hay archivos guardados de este tipo.';
	@override String get delete_title => 'Eliminar archivos';
	@override String delete_message({required Object count}) => 'Se eliminará(n) ${count} archivo(s) permanentemente.\nEsta acción no se puede deshacer.';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Eliminar';
	@override String selected_count({required Object count}) => '${count} seleccionado(s)';
	@override String get cancel_selection_tooltip => 'Cancelar selección';
	@override String get delete_selected_tooltip => 'Eliminar seleccionados';
	@override String file_count({required Object count}) => '${count} archivo(s)';
	@override String header_path({required Object dirName}) => 'Pictures/${dirName}';
}

// Path: permission
class _Translations$permission$es extends Translations$permission$en {
	_Translations$permission$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acceso al almacenamiento requerido';
	@override String get description => 'Statuses necesita acceso a tu almacenamiento para leer los archivos multimedia de estados de WhatsApp. Tus archivos permanecen en tu dispositivo.';
	@override String get grant_access => 'Conceder acceso';
	@override String get permanently_denied => 'El permiso fue denegado permanentemente.\nActívalo en Ajustes.';
	@override String get open_settings => 'Abrir Ajustes';
	@override String get privacy_note => 'Tus datos permanecen en tu dispositivo.\nStatuses no recopila ninguna información.';
}

// Path: empty
class _Translations$empty$es extends Translations$empty$en {
	_Translations$empty$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get default_title => 'No se encontraron historias';
	@override String get default_subtitle => 'Abre WhatsApp, ve algunas historias y vuelve aquí.';
	@override String get saf_instructions => 'Si el problema persiste, concede acceso manual a la carpeta:';
	@override String get saf_button => 'Seleccionar carpeta .Statuses';
}

// Path: date
class _Translations$date$es extends Translations$date$en {
	_Translations$date$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
	@override String days_ago({required Object count}) => 'hace ${count} días';
	@override String get week_ago => 'hace 1 semana';
	@override String weeks_ago({required Object count}) => 'hace ${count} semanas';
	@override String get at => 'a las';
}

// Path: settings
class _Translations$settings$es extends Translations$settings$en {
	_Translations$settings$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configuración';
	@override String get appearance => 'Apariencia';
	@override String get language => 'Idioma';
	@override String get theme => 'Tema';
	@override String get light => 'Claro';
	@override String get dark => 'Oscuro';
	@override String get toggle_view => 'Cambiar vista';
	@override String get toggle_theme => 'Cambiar tema';
	@override String get help => 'Ayuda';
	@override String get help_center => 'Centro de ayuda';
	@override String get about => 'Acerca de';
	@override String get app_name => 'Statuses';
	@override String get app_description => 'Visualiza y gestiona archivos multimedia de historias de WhatsApp';
	@override String get version => 'Versión';
}

// Path: help
class _Translations$help$es extends Translations$help$en {
	_Translations$help$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Centro de ayuda';
	@override String get how_to_use_title => 'Cómo usar';
	@override String get grant_permissions_title => 'Conceder permisos';
	@override String get grant_permissions_body => 'Al abrir la app por primera vez, se solicitará acceso al almacenamiento. Toca "Conceder acceso" para permitir la lectura de los estados de WhatsApp. Tus archivos permanecen en tu dispositivo.';
	@override String get view_statuses_title => 'Ver historias';
	@override String get view_statuses_body => 'Abre WhatsApp y visualiza algunas historias. Luego vuelve a Statuses y aparecerán automáticamente. Usa los filtros para mostrar todo, fotos o videos.';
	@override String get save_statuses_title => 'Guardar historias';
	@override String get save_statuses_body => 'Toca una historia para abrirla en pantalla completa. Usa el botón de descarga o el menú para guardarla en tu dispositivo.';
	@override String get share_content_title => 'Compartir contenido';
	@override String get share_content_body => 'Abre una historia y toca el botón de compartir o usa el menú para compartirla con otras aplicaciones.';
	@override String get switch_view_title => 'Cambiar entre vista de cuadrícula y lista';
	@override String get switch_view_body => 'Toca el icono de cuadrícula/lista en la barra superior para alternar entre una vista compacta en cuadrícula y una vista detallada en lista.';
	@override String get dark_mode_title => 'Modo oscuro';
	@override String get dark_mode_body => 'Puedes cambiar entre modo claro y oscuro en Configuración. La app también sigue el tema del sistema automáticamente.';
	@override String get faq_title => 'Preguntas frecuentes';
	@override String get faq_encrypted_names_q => '¿Por qué los archivos tienen nombres extraños?';
	@override String get faq_encrypted_names_a => 'WhatsApp almacena temporalmente los estados utilizando nombres internos generados automáticamente por el sistema. Estos nombres no corresponden al nombre original del archivo y son utilizados por WhatsApp para optimizar el almacenamiento y la gestión del contenido. Esto es completamente normal y no afecta la visualización ni el funcionamiento de los estados.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Statuses',
			'filter.all' => 'Todo',
			'filter.photos' => 'Fotos',
			'filter.videos' => 'Videos',
			'nav.statuses' => 'Historias',
			'nav.saved' => 'Guardados',
			'detail.download' => 'Descargar',
			'detail.share' => 'Compartir',
			'detail.info' => 'Información',
			'detail.close' => 'Cerrar',
			'detail.file_info' => 'Información del archivo',
			'detail.name' => 'Nombre',
			'detail.size' => 'Tamaño',
			'detail.type' => 'Tipo',
			'detail.date' => 'Fecha',
			'detail.file_not_found' => 'Archivo no encontrado',
			'detail.unable_to_load_image' => 'No se pudo cargar la imagen',
			'detail.loading_video' => 'Cargando video...',
			'detail.unsupported_file_type' => 'Tipo de archivo no soportado',
			'detail.saved_successfully' => 'Archivo guardado correctamente',
			'detail.video_badge' => 'VIDEO',
			'saved.empty_title' => 'Sin historias guardadas',
			'saved.empty_subtitle' => 'Las historias que descargues aparecerán aquí.',
			'saved.empty_filtered_title' => 'Sin resultados',
			'saved.empty_filtered_subtitle' => 'No hay archivos guardados de este tipo.',
			'saved.delete_title' => 'Eliminar archivos',
			'saved.delete_message' => ({required Object count}) => 'Se eliminará(n) ${count} archivo(s) permanentemente.\nEsta acción no se puede deshacer.',
			'saved.cancel' => 'Cancelar',
			'saved.delete' => 'Eliminar',
			'saved.selected_count' => ({required Object count}) => '${count} seleccionado(s)',
			'saved.cancel_selection_tooltip' => 'Cancelar selección',
			'saved.delete_selected_tooltip' => 'Eliminar seleccionados',
			'saved.file_count' => ({required Object count}) => '${count} archivo(s)',
			'saved.header_path' => ({required Object dirName}) => 'Pictures/${dirName}',
			'permission.title' => 'Acceso al almacenamiento requerido',
			'permission.description' => 'Statuses necesita acceso a tu almacenamiento para leer los archivos multimedia de estados de WhatsApp. Tus archivos permanecen en tu dispositivo.',
			'permission.grant_access' => 'Conceder acceso',
			'permission.permanently_denied' => 'El permiso fue denegado permanentemente.\nActívalo en Ajustes.',
			'permission.open_settings' => 'Abrir Ajustes',
			'permission.privacy_note' => 'Tus datos permanecen en tu dispositivo.\nStatuses no recopila ninguna información.',
			'empty.default_title' => 'No se encontraron historias',
			'empty.default_subtitle' => 'Abre WhatsApp, ve algunas historias y vuelve aquí.',
			'empty.saf_instructions' => 'Si el problema persiste, concede acceso manual a la carpeta:',
			'empty.saf_button' => 'Seleccionar carpeta .Statuses',
			'date.today' => 'Hoy',
			'date.yesterday' => 'Ayer',
			'date.days_ago' => ({required Object count}) => 'hace ${count} días',
			'date.week_ago' => 'hace 1 semana',
			'date.weeks_ago' => ({required Object count}) => 'hace ${count} semanas',
			'date.at' => 'a las',
			'settings.title' => 'Configuración',
			'settings.appearance' => 'Apariencia',
			'settings.language' => 'Idioma',
			'settings.theme' => 'Tema',
			'settings.light' => 'Claro',
			'settings.dark' => 'Oscuro',
			'settings.toggle_view' => 'Cambiar vista',
			'settings.toggle_theme' => 'Cambiar tema',
			'settings.help' => 'Ayuda',
			'settings.help_center' => 'Centro de ayuda',
			'settings.about' => 'Acerca de',
			'settings.app_name' => 'Statuses',
			'settings.app_description' => 'Visualiza y gestiona archivos multimedia de historias de WhatsApp',
			'settings.version' => 'Versión',
			'help.title' => 'Centro de ayuda',
			'help.how_to_use_title' => 'Cómo usar',
			'help.grant_permissions_title' => 'Conceder permisos',
			'help.grant_permissions_body' => 'Al abrir la app por primera vez, se solicitará acceso al almacenamiento. Toca "Conceder acceso" para permitir la lectura de los estados de WhatsApp. Tus archivos permanecen en tu dispositivo.',
			'help.view_statuses_title' => 'Ver historias',
			'help.view_statuses_body' => 'Abre WhatsApp y visualiza algunas historias. Luego vuelve a Statuses y aparecerán automáticamente. Usa los filtros para mostrar todo, fotos o videos.',
			'help.save_statuses_title' => 'Guardar historias',
			'help.save_statuses_body' => 'Toca una historia para abrirla en pantalla completa. Usa el botón de descarga o el menú para guardarla en tu dispositivo.',
			'help.share_content_title' => 'Compartir contenido',
			'help.share_content_body' => 'Abre una historia y toca el botón de compartir o usa el menú para compartirla con otras aplicaciones.',
			'help.switch_view_title' => 'Cambiar entre vista de cuadrícula y lista',
			'help.switch_view_body' => 'Toca el icono de cuadrícula/lista en la barra superior para alternar entre una vista compacta en cuadrícula y una vista detallada en lista.',
			'help.dark_mode_title' => 'Modo oscuro',
			'help.dark_mode_body' => 'Puedes cambiar entre modo claro y oscuro en Configuración. La app también sigue el tema del sistema automáticamente.',
			'help.faq_title' => 'Preguntas frecuentes',
			'help.faq_encrypted_names_q' => '¿Por qué los archivos tienen nombres extraños?',
			'help.faq_encrypted_names_a' => 'WhatsApp almacena temporalmente los estados utilizando nombres internos generados automáticamente por el sistema. Estos nombres no corresponden al nombre original del archivo y son utilizados por WhatsApp para optimizar el almacenamiento y la gestión del contenido. Esto es completamente normal y no afecta la visualización ni el funcionamiento de los estados.',
			_ => null,
		};
	}
}
