pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 12.3.0" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_utiliser_piles" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#09d5b977#;
   pragma Export (C, u00001, "utiliser_pilesB");
   u00002 : constant Version_32 := 16#7320ff5f#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#b0d43184#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00005, "ada__charactersS");
   u00006 : constant Version_32 := 16#cde9ea2d#;
   pragma Export (C, u00006, "ada__characters__latin_1S");
   u00007 : constant Version_32 := 16#f64b89a4#;
   pragma Export (C, u00007, "ada__integer_text_ioB");
   u00008 : constant Version_32 := 16#5e9ebd8f#;
   pragma Export (C, u00008, "ada__integer_text_ioS");
   u00009 : constant Version_32 := 16#7b8a0989#;
   pragma Export (C, u00009, "ada__exceptionsB");
   u00010 : constant Version_32 := 16#fec21d10#;
   pragma Export (C, u00010, "ada__exceptionsS");
   u00011 : constant Version_32 := 16#0740df23#;
   pragma Export (C, u00011, "ada__exceptions__last_chance_handlerB");
   u00012 : constant Version_32 := 16#6dc27684#;
   pragma Export (C, u00012, "ada__exceptions__last_chance_handlerS");
   u00013 : constant Version_32 := 16#a2da961d#;
   pragma Export (C, u00013, "systemS");
   u00014 : constant Version_32 := 16#fd5f5f4c#;
   pragma Export (C, u00014, "system__soft_linksB");
   u00015 : constant Version_32 := 16#ea08eb09#;
   pragma Export (C, u00015, "system__soft_linksS");
   u00016 : constant Version_32 := 16#e12f1eb0#;
   pragma Export (C, u00016, "system__secondary_stackB");
   u00017 : constant Version_32 := 16#790dbf4d#;
   pragma Export (C, u00017, "system__secondary_stackS");
   u00018 : constant Version_32 := 16#821dff88#;
   pragma Export (C, u00018, "system__parametersB");
   u00019 : constant Version_32 := 16#764e32bb#;
   pragma Export (C, u00019, "system__parametersS");
   u00020 : constant Version_32 := 16#ec4fa52d#;
   pragma Export (C, u00020, "system__storage_elementsB");
   u00021 : constant Version_32 := 16#cf5489e9#;
   pragma Export (C, u00021, "system__storage_elementsS");
   u00022 : constant Version_32 := 16#37c92568#;
   pragma Export (C, u00022, "system__soft_links__initializeB");
   u00023 : constant Version_32 := 16#2ed17187#;
   pragma Export (C, u00023, "system__soft_links__initializeS");
   u00024 : constant Version_32 := 16#8599b27b#;
   pragma Export (C, u00024, "system__stack_checkingB");
   u00025 : constant Version_32 := 16#c4d54817#;
   pragma Export (C, u00025, "system__stack_checkingS");
   u00026 : constant Version_32 := 16#c71e6c8a#;
   pragma Export (C, u00026, "system__exception_tableB");
   u00027 : constant Version_32 := 16#2ff1e004#;
   pragma Export (C, u00027, "system__exception_tableS");
   u00028 : constant Version_32 := 16#907f292f#;
   pragma Export (C, u00028, "system__exceptionsS");
   u00029 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00029, "system__exceptions__machineB");
   u00030 : constant Version_32 := 16#8bdfdbe3#;
   pragma Export (C, u00030, "system__exceptions__machineS");
   u00031 : constant Version_32 := 16#7706238d#;
   pragma Export (C, u00031, "system__exceptions_debugB");
   u00032 : constant Version_32 := 16#92d4ce4e#;
   pragma Export (C, u00032, "system__exceptions_debugS");
   u00033 : constant Version_32 := 16#1253e556#;
   pragma Export (C, u00033, "system__img_intS");
   u00034 : constant Version_32 := 16#5c7d9c20#;
   pragma Export (C, u00034, "system__tracebackB");
   u00035 : constant Version_32 := 16#244062a0#;
   pragma Export (C, u00035, "system__tracebackS");
   u00036 : constant Version_32 := 16#5f6b6486#;
   pragma Export (C, u00036, "system__traceback_entriesB");
   u00037 : constant Version_32 := 16#6ac62991#;
   pragma Export (C, u00037, "system__traceback_entriesS");
   u00038 : constant Version_32 := 16#69fd68e2#;
   pragma Export (C, u00038, "system__traceback__symbolicB");
   u00039 : constant Version_32 := 16#d9e66ad1#;
   pragma Export (C, u00039, "system__traceback__symbolicS");
   u00040 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00040, "ada__containersS");
   u00041 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00041, "ada__exceptions__tracebackB");
   u00042 : constant Version_32 := 16#eb07882c#;
   pragma Export (C, u00042, "ada__exceptions__tracebackS");
   u00043 : constant Version_32 := 16#edec285f#;
   pragma Export (C, u00043, "interfacesS");
   u00044 : constant Version_32 := 16#7f1e3740#;
   pragma Export (C, u00044, "interfaces__cB");
   u00045 : constant Version_32 := 16#1bfc3385#;
   pragma Export (C, u00045, "interfaces__cS");
   u00046 : constant Version_32 := 16#a828b371#;
   pragma Export (C, u00046, "system__bounded_stringsB");
   u00047 : constant Version_32 := 16#d527b704#;
   pragma Export (C, u00047, "system__bounded_stringsS");
   u00048 : constant Version_32 := 16#fc48a043#;
   pragma Export (C, u00048, "system__crtlS");
   u00049 : constant Version_32 := 16#173d8a0c#;
   pragma Export (C, u00049, "system__dwarf_linesB");
   u00050 : constant Version_32 := 16#457ca30b#;
   pragma Export (C, u00050, "system__dwarf_linesS");
   u00051 : constant Version_32 := 16#a5e53111#;
   pragma Export (C, u00051, "ada__characters__handlingB");
   u00052 : constant Version_32 := 16#763c2a94#;
   pragma Export (C, u00052, "ada__characters__handlingS");
   u00053 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00053, "ada__stringsS");
   u00054 : constant Version_32 := 16#6424b9ce#;
   pragma Export (C, u00054, "ada__strings__mapsB");
   u00055 : constant Version_32 := 16#5349602c#;
   pragma Export (C, u00055, "ada__strings__mapsS");
   u00056 : constant Version_32 := 16#96b40646#;
   pragma Export (C, u00056, "system__bit_opsB");
   u00057 : constant Version_32 := 16#6f293a21#;
   pragma Export (C, u00057, "system__bit_opsS");
   u00058 : constant Version_32 := 16#58f0e944#;
   pragma Export (C, u00058, "system__unsigned_typesS");
   u00059 : constant Version_32 := 16#88fa2db0#;
   pragma Export (C, u00059, "ada__strings__maps__constantsS");
   u00060 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00060, "system__address_imageB");
   u00061 : constant Version_32 := 16#03360b27#;
   pragma Export (C, u00061, "system__address_imageS");
   u00062 : constant Version_32 := 16#04e17b2e#;
   pragma Export (C, u00062, "system__img_unsS");
   u00063 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00063, "system__ioB");
   u00064 : constant Version_32 := 16#3c986152#;
   pragma Export (C, u00064, "system__ioS");
   u00065 : constant Version_32 := 16#754b4bb8#;
   pragma Export (C, u00065, "system__mmapB");
   u00066 : constant Version_32 := 16#e42f418c#;
   pragma Export (C, u00066, "system__mmapS");
   u00067 : constant Version_32 := 16#367911c4#;
   pragma Export (C, u00067, "ada__io_exceptionsS");
   u00068 : constant Version_32 := 16#dd82c35a#;
   pragma Export (C, u00068, "system__mmap__os_interfaceB");
   u00069 : constant Version_32 := 16#37fd3b64#;
   pragma Export (C, u00069, "system__mmap__os_interfaceS");
   u00070 : constant Version_32 := 16#40e7f3aa#;
   pragma Export (C, u00070, "system__mmap__unixS");
   u00071 : constant Version_32 := 16#3d77d417#;
   pragma Export (C, u00071, "system__os_libB");
   u00072 : constant Version_32 := 16#58b64642#;
   pragma Export (C, u00072, "system__os_libS");
   u00073 : constant Version_32 := 16#6e5d049a#;
   pragma Export (C, u00073, "system__atomic_operations__test_and_setB");
   u00074 : constant Version_32 := 16#57acee8e#;
   pragma Export (C, u00074, "system__atomic_operations__test_and_setS");
   u00075 : constant Version_32 := 16#65b9ec38#;
   pragma Export (C, u00075, "system__atomic_operationsS");
   u00076 : constant Version_32 := 16#29cc6115#;
   pragma Export (C, u00076, "system__atomic_primitivesB");
   u00077 : constant Version_32 := 16#9b4d0d57#;
   pragma Export (C, u00077, "system__atomic_primitivesS");
   u00078 : constant Version_32 := 16#b98923bf#;
   pragma Export (C, u00078, "system__case_utilB");
   u00079 : constant Version_32 := 16#6dc94148#;
   pragma Export (C, u00079, "system__case_utilS");
   u00080 : constant Version_32 := 16#256dbbe5#;
   pragma Export (C, u00080, "system__stringsB");
   u00081 : constant Version_32 := 16#39589605#;
   pragma Export (C, u00081, "system__stringsS");
   u00082 : constant Version_32 := 16#51051765#;
   pragma Export (C, u00082, "system__object_readerB");
   u00083 : constant Version_32 := 16#4d58338b#;
   pragma Export (C, u00083, "system__object_readerS");
   u00084 : constant Version_32 := 16#6fe12729#;
   pragma Export (C, u00084, "system__val_lliS");
   u00085 : constant Version_32 := 16#79b18bfd#;
   pragma Export (C, u00085, "system__val_lluS");
   u00086 : constant Version_32 := 16#273bd629#;
   pragma Export (C, u00086, "system__val_utilB");
   u00087 : constant Version_32 := 16#20c400bb#;
   pragma Export (C, u00087, "system__val_utilS");
   u00088 : constant Version_32 := 16#bad10b33#;
   pragma Export (C, u00088, "system__exception_tracesB");
   u00089 : constant Version_32 := 16#4e42ff7b#;
   pragma Export (C, u00089, "system__exception_tracesS");
   u00090 : constant Version_32 := 16#fd158a37#;
   pragma Export (C, u00090, "system__wch_conB");
   u00091 : constant Version_32 := 16#7bd9b57e#;
   pragma Export (C, u00091, "system__wch_conS");
   u00092 : constant Version_32 := 16#5c289972#;
   pragma Export (C, u00092, "system__wch_stwB");
   u00093 : constant Version_32 := 16#56c8997f#;
   pragma Export (C, u00093, "system__wch_stwS");
   u00094 : constant Version_32 := 16#002bec7b#;
   pragma Export (C, u00094, "system__wch_cnvB");
   u00095 : constant Version_32 := 16#7d197f0e#;
   pragma Export (C, u00095, "system__wch_cnvS");
   u00096 : constant Version_32 := 16#e538de43#;
   pragma Export (C, u00096, "system__wch_jisB");
   u00097 : constant Version_32 := 16#c8ae1d24#;
   pragma Export (C, u00097, "system__wch_jisS");
   u00098 : constant Version_32 := 16#e56aa583#;
   pragma Export (C, u00098, "ada__text_ioB");
   u00099 : constant Version_32 := 16#5ec7e357#;
   pragma Export (C, u00099, "ada__text_ioS");
   u00100 : constant Version_32 := 16#b4f41810#;
   pragma Export (C, u00100, "ada__streamsB");
   u00101 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00101, "ada__streamsS");
   u00102 : constant Version_32 := 16#a94883d4#;
   pragma Export (C, u00102, "ada__strings__text_buffersB");
   u00103 : constant Version_32 := 16#bb49bb93#;
   pragma Export (C, u00103, "ada__strings__text_buffersS");
   u00104 : constant Version_32 := 16#7e7d940a#;
   pragma Export (C, u00104, "ada__strings__utf_encodingB");
   u00105 : constant Version_32 := 16#84aa91b0#;
   pragma Export (C, u00105, "ada__strings__utf_encodingS");
   u00106 : constant Version_32 := 16#d1d1ed0b#;
   pragma Export (C, u00106, "ada__strings__utf_encoding__wide_stringsB");
   u00107 : constant Version_32 := 16#a373d741#;
   pragma Export (C, u00107, "ada__strings__utf_encoding__wide_stringsS");
   u00108 : constant Version_32 := 16#c2b98963#;
   pragma Export (C, u00108, "ada__strings__utf_encoding__wide_wide_stringsB");
   u00109 : constant Version_32 := 16#22a4a396#;
   pragma Export (C, u00109, "ada__strings__utf_encoding__wide_wide_stringsS");
   u00110 : constant Version_32 := 16#c3fbe91b#;
   pragma Export (C, u00110, "ada__tagsB");
   u00111 : constant Version_32 := 16#8bc79dfc#;
   pragma Export (C, u00111, "ada__tagsS");
   u00112 : constant Version_32 := 16#3548d972#;
   pragma Export (C, u00112, "system__htableB");
   u00113 : constant Version_32 := 16#2303cef6#;
   pragma Export (C, u00113, "system__htableS");
   u00114 : constant Version_32 := 16#1f1abe38#;
   pragma Export (C, u00114, "system__string_hashB");
   u00115 : constant Version_32 := 16#84464e89#;
   pragma Export (C, u00115, "system__string_hashS");
   u00116 : constant Version_32 := 16#5fc04ee2#;
   pragma Export (C, u00116, "system__put_imagesB");
   u00117 : constant Version_32 := 16#0ed92da1#;
   pragma Export (C, u00117, "system__put_imagesS");
   u00118 : constant Version_32 := 16#22b9eb9f#;
   pragma Export (C, u00118, "ada__strings__text_buffers__utilsB");
   u00119 : constant Version_32 := 16#608bd105#;
   pragma Export (C, u00119, "ada__strings__text_buffers__utilsS");
   u00120 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00120, "interfaces__c_streamsB");
   u00121 : constant Version_32 := 16#82d73129#;
   pragma Export (C, u00121, "interfaces__c_streamsS");
   u00122 : constant Version_32 := 16#1aa716c1#;
   pragma Export (C, u00122, "system__file_ioB");
   u00123 : constant Version_32 := 16#de785348#;
   pragma Export (C, u00123, "system__file_ioS");
   u00124 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00124, "ada__finalizationS");
   u00125 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00125, "system__finalization_rootB");
   u00126 : constant Version_32 := 16#ed28e58d#;
   pragma Export (C, u00126, "system__finalization_rootS");
   u00127 : constant Version_32 := 16#002b610c#;
   pragma Export (C, u00127, "system__file_control_blockS");
   u00128 : constant Version_32 := 16#44bc8f6a#;
   pragma Export (C, u00128, "ada__text_io__generic_auxB");
   u00129 : constant Version_32 := 16#38ee6479#;
   pragma Export (C, u00129, "ada__text_io__generic_auxS");
   u00130 : constant Version_32 := 16#6b2d15e3#;
   pragma Export (C, u00130, "system__img_biuS");
   u00131 : constant Version_32 := 16#2673d23d#;
   pragma Export (C, u00131, "system__img_llbS");
   u00132 : constant Version_32 := 16#98c6c945#;
   pragma Export (C, u00132, "system__img_lliS");
   u00133 : constant Version_32 := 16#5182274f#;
   pragma Export (C, u00133, "system__img_lllbS");
   u00134 : constant Version_32 := 16#f316ccbd#;
   pragma Export (C, u00134, "system__img_llliS");
   u00135 : constant Version_32 := 16#5bf63e43#;
   pragma Export (C, u00135, "system__img_lllwS");
   u00136 : constant Version_32 := 16#7a41a736#;
   pragma Export (C, u00136, "system__img_llwS");
   u00137 : constant Version_32 := 16#54f7aed1#;
   pragma Export (C, u00137, "system__img_wiuS");
   u00138 : constant Version_32 := 16#40199964#;
   pragma Export (C, u00138, "system__val_intS");
   u00139 : constant Version_32 := 16#5b7e5917#;
   pragma Export (C, u00139, "system__val_unsS");
   u00140 : constant Version_32 := 16#3738e9f5#;
   pragma Export (C, u00140, "system__val_llliS");
   u00141 : constant Version_32 := 16#4f0fea27#;
   pragma Export (C, u00141, "system__val_llluS");
   u00142 : constant Version_32 := 16#d317b445#;
   pragma Export (C, u00142, "pilesB");
   u00143 : constant Version_32 := 16#f8ba9f4f#;
   pragma Export (C, u00143, "pilesS");
   u00144 : constant Version_32 := 16#2fb34529#;
   pragma Export (C, u00144, "system__assertionsB");
   u00145 : constant Version_32 := 16#84d9e986#;
   pragma Export (C, u00145, "system__assertionsS");
   u00146 : constant Version_32 := 16#8b2c6428#;
   pragma Export (C, u00146, "ada__assertionsB");
   u00147 : constant Version_32 := 16#cc3ec2fd#;
   pragma Export (C, u00147, "ada__assertionsS");
   u00148 : constant Version_32 := 16#f3aa0da6#;
   pragma Export (C, u00148, "system__concat_3B");
   u00149 : constant Version_32 := 16#32a27e7d#;
   pragma Export (C, u00149, "system__concat_3S");
   u00150 : constant Version_32 := 16#4aa988d0#;
   pragma Export (C, u00150, "system__concat_2B");
   u00151 : constant Version_32 := 16#9f9c931f#;
   pragma Export (C, u00151, "system__concat_2S");
   u00152 : constant Version_32 := 16#1982dcd0#;
   pragma Export (C, u00152, "system__memoryB");
   u00153 : constant Version_32 := 16#f95ea4cd#;
   pragma Export (C, u00153, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.atomic_operations%s
   --  system.img_int%s
   --  system.img_lli%s
   --  system.img_llli%s
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_biu%s
   --  system.img_llb%s
   --  system.img_lllb%s
   --  system.img_lllw%s
   --  system.img_llw%s
   --  system.img_uns%s
   --  system.img_wiu%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.atomic_operations.test_and_set%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.atomic_primitives%s
   --  system.atomic_primitives%b
   --  system.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  ada.characters.handling%b
   --  system.atomic_operations.test_and_set%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.assertions%s
   --  ada.assertions%b
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding%b
   --  ada.strings.utf_encoding.wide_strings%s
   --  ada.strings.utf_encoding.wide_strings%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.strings.text_buffers%s
   --  ada.strings.text_buffers%b
   --  ada.strings.text_buffers.utils%s
   --  ada.strings.text_buffers.utils%b
   --  system.put_images%s
   --  system.put_images%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.val_lllu%s
   --  system.val_llli%s
   --  system.val_uns%s
   --  system.val_int%s
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
   --  system.assertions%s
   --  system.assertions%b
   --  piles%s
   --  piles%b
   --  utiliser_piles%b
   --  END ELABORATION ORDER

end ada_main;
