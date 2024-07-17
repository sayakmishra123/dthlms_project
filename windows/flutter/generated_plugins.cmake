#
# Generated file, do not edit.
#

list(APPEND FLUTTER_PLUGIN_LIST
  animated_progress_bar
  cloud_firestore
  connectivity_plus
  desktop_multi_window
  file_selector_windows
  firebase_auth
  firebase_core
  firebase_storage
  flutter_platform_alert
  flutter_secure_storage_windows
  local_notifier
  media_kit_libs_windows_video
  media_kit_video
  permission_handler_windows
  printing
  screen_brightness_windows
  syncfusion_pdfviewer_windows
  url_launcher_windows
  webview_universal
  window_size
  windows_single_instance
)

list(APPEND FLUTTER_FFI_PLUGIN_LIST
  media_kit_native_event_loop
)

set(PLUGIN_BUNDLED_LIBRARIES)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/windows plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach(plugin)

foreach(ffi_plugin ${FLUTTER_FFI_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${ffi_plugin}/windows plugins/${ffi_plugin})
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${ffi_plugin}_bundled_libraries})
endforeach(ffi_plugin)
