; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [343 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [680 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 68
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 67
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 108
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 260
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 297
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 48
	i32 39485524, ; 6: System.Net.WebSockets.dll => 0x25a8054 => 80
	i32 42639949, ; 7: System.Threading.Thread => 0x28aa24d => 145
	i32 66541672, ; 8: System.Diagnostics.StackTrace => 0x3f75868 => 30
	i32 67008169, ; 9: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 338
	i32 68219467, ; 10: System.Security.Cryptography.Primitives => 0x410f24b => 124
	i32 72070932, ; 11: Microsoft.Maui.Graphics.dll => 0x44bb714 => 192
	i32 82292897, ; 12: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 102
	i32 101534019, ; 13: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 279
	i32 117431740, ; 14: System.Runtime.InteropServices => 0x6ffddbc => 107
	i32 120558881, ; 15: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 279
	i32 122350210, ; 16: System.Threading.Channels.dll => 0x74aea82 => 139
	i32 134690465, ; 17: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 301
	i32 142721839, ; 18: System.Net.WebHeaderCollection => 0x881c32f => 77
	i32 149972175, ; 19: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 124
	i32 159306688, ; 20: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 21: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 234
	i32 172961045, ; 22: Syncfusion.Maui.Core.dll => 0xa4f2d15 => 203
	i32 176265551, ; 23: System.ServiceProcess => 0xa81994f => 132
	i32 182336117, ; 24: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 281
	i32 184328833, ; 25: System.ValueTuple.dll => 0xafca281 => 151
	i32 195452805, ; 26: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 335
	i32 199333315, ; 27: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 336
	i32 205061960, ; 28: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 29: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 232
	i32 220171995, ; 30: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 31: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 254
	i32 230752869, ; 32: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 33: System.Linq.Parallel => 0xdcb05c4 => 59
	i32 231814094, ; 34: System.Globalization => 0xdd133ce => 42
	i32 246610117, ; 35: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 91
	i32 261689757, ; 36: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 237
	i32 266337479, ; 37: Xamarin.Google.Guava.FailureAccess.dll => 0xfdffcc7 => 296
	i32 276479776, ; 38: System.Threading.Timer.dll => 0x107abf20 => 147
	i32 278686392, ; 39: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 256
	i32 280482487, ; 40: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 253
	i32 280992041, ; 41: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 307
	i32 291076382, ; 42: System.IO.Pipes.AccessControl.dll => 0x1159791e => 54
	i32 293579439, ; 43: ExoPlayer.Dash.dll => 0x117faaaf => 208
	i32 298918909, ; 44: System.Net.Ping.dll => 0x11d123fd => 69
	i32 317674968, ; 45: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 335
	i32 318968648, ; 46: Xamarin.AndroidX.Activity.dll => 0x13031348 => 223
	i32 321597661, ; 47: System.Numerics => 0x132b30dd => 83
	i32 336156722, ; 48: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 320
	i32 342366114, ; 49: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 255
	i32 347068432, ; 50: SQLitePCLRaw.lib.e_sqlite3.android.dll => 0x14afd810 => 199
	i32 356389973, ; 51: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 319
	i32 360082299, ; 52: System.ServiceModel.Web => 0x15766b7b => 131
	i32 367780167, ; 53: System.IO.Pipes => 0x15ebe147 => 55
	i32 374914964, ; 54: System.Transactions.Local => 0x1658bf94 => 149
	i32 375677976, ; 55: System.Net.ServicePoint.dll => 0x16646418 => 74
	i32 379916513, ; 56: System.Threading.Thread.dll => 0x16a510e1 => 145
	i32 385762202, ; 57: System.Memory.dll => 0x16fe439a => 62
	i32 392610295, ; 58: System.Threading.ThreadPool.dll => 0x1766c1f7 => 146
	i32 395744057, ; 59: _Microsoft.Android.Resource.Designer => 0x17969339 => 339
	i32 403441872, ; 60: WindowsBase => 0x180c08d0 => 165
	i32 435591531, ; 61: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 331
	i32 441335492, ; 62: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 238
	i32 442565967, ; 63: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 64: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 251
	i32 451504562, ; 65: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 125
	i32 452127346, ; 66: ExoPlayer.Database.dll => 0x1af2ea72 => 209
	i32 456227837, ; 67: System.Web.HttpUtility.dll => 0x1b317bfd => 152
	i32 459347974, ; 68: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 113
	i32 465846621, ; 69: mscorlib => 0x1bc4415d => 166
	i32 469710990, ; 70: System.dll => 0x1bff388e => 164
	i32 476646585, ; 71: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 253
	i32 486930444, ; 72: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 266
	i32 498788369, ; 73: System.ObjectModel => 0x1dbae811 => 84
	i32 500358224, ; 74: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 318
	i32 503918385, ; 75: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 312
	i32 513247710, ; 76: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 186
	i32 526420162, ; 77: System.Transactions.dll => 0x1f6088c2 => 150
	i32 527452488, ; 78: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 301
	i32 530272170, ; 79: System.Linq.Queryable => 0x1f9b4faa => 60
	i32 539058512, ; 80: Microsoft.Extensions.Logging => 0x20216150 => 182
	i32 540030774, ; 81: System.IO.FileSystem.dll => 0x20303736 => 51
	i32 545304856, ; 82: System.Runtime.Extensions => 0x2080b118 => 103
	i32 546455878, ; 83: System.Runtime.Serialization.Xml => 0x20924146 => 114
	i32 549171840, ; 84: System.Globalization.Calendars => 0x20bbb280 => 40
	i32 557405415, ; 85: Jsr305Binding => 0x213954e7 => 292
	i32 569601784, ; 86: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 290
	i32 577335427, ; 87: System.Security.Cryptography.Cng => 0x22697083 => 120
	i32 592146354, ; 88: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 326
	i32 597488923, ; 89: CommunityToolkit.Maui => 0x239cf51b => 173
	i32 601371474, ; 90: System.IO.IsolatedStorage.dll => 0x23d83352 => 52
	i32 605376203, ; 91: System.IO.Compression.FileSystem => 0x24154ecb => 44
	i32 613668793, ; 92: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 119
	i32 626887733, ; 93: ExoPlayer.Container => 0x255d8c35 => 206
	i32 627609679, ; 94: Xamarin.AndroidX.CustomView => 0x2568904f => 243
	i32 627931235, ; 95: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 324
	i32 639843206, ; 96: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 249
	i32 643868501, ; 97: System.Net => 0x2660a755 => 81
	i32 662205335, ; 98: System.Text.Encodings.Web.dll => 0x27787397 => 136
	i32 663517072, ; 99: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 286
	i32 666292255, ; 100: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 230
	i32 672442732, ; 101: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 102: System.Net.Security => 0x28bdabca => 73
	i32 688181140, ; 103: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 306
	i32 690569205, ; 104: System.Xml.Linq.dll => 0x29293ff5 => 155
	i32 691348768, ; 105: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 303
	i32 693804605, ; 106: System.Windows => 0x295a9e3d => 154
	i32 699345723, ; 107: System.Reflection.Emit => 0x29af2b3b => 92
	i32 700284507, ; 108: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 298
	i32 700358131, ; 109: System.IO.Compression.ZipFile => 0x29be9df3 => 45
	i32 706645707, ; 110: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 321
	i32 709557578, ; 111: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 309
	i32 720511267, ; 112: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 302
	i32 722857257, ; 113: System.Runtime.Loader.dll => 0x2b15ed29 => 109
	i32 735137430, ; 114: System.Security.SecureString.dll => 0x2bd14e96 => 129
	i32 748832960, ; 115: SQLitePCLRaw.batteries_v2 => 0x2ca248c0 => 196
	i32 752232764, ; 116: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 752882528, ; 117: SQLitePCLRaw.provider.dynamic_cdecl.dll => 0x2ce01360 => 200
	i32 755313932, ; 118: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 220
	i32 759454413, ; 119: System.Net.Requests => 0x2d445acd => 72
	i32 762598435, ; 120: System.IO.Pipes.dll => 0x2d745423 => 55
	i32 775507847, ; 121: System.IO.Compression => 0x2e394f87 => 46
	i32 777317022, ; 122: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 330
	i32 789151979, ; 123: Microsoft.Extensions.Options => 0x2f0980eb => 185
	i32 790371945, ; 124: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 244
	i32 804715423, ; 125: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 126: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 258
	i32 812693636, ; 127: ExoPlayer.Dash => 0x3070b884 => 208
	i32 823281589, ; 128: System.Private.Uri.dll => 0x311247b5 => 86
	i32 830298997, ; 129: System.IO.Compression.Brotli => 0x317d5b75 => 43
	i32 832635846, ; 130: System.Xml.XPath.dll => 0x31a103c6 => 160
	i32 834051424, ; 131: System.Net.Quic => 0x31b69d60 => 71
	i32 835661280, ; 132: MvvmHelpers.dll => 0x31cf2de0 => 194
	i32 843511501, ; 133: Xamarin.AndroidX.Print => 0x3246f6cd => 272
	i32 873119928, ; 134: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 135: System.Globalization.dll => 0x34505120 => 42
	i32 878954865, ; 136: System.Net.Http.Json => 0x3463c971 => 63
	i32 904024072, ; 137: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 138: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 53
	i32 915551335, ; 139: ExoPlayer.Ext.MediaSession => 0x36923467 => 214
	i32 926902833, ; 140: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 333
	i32 928116545, ; 141: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 297
	i32 939704684, ; 142: ExoPlayer.Extractor => 0x3802c16c => 212
	i32 952186615, ; 143: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 105
	i32 952358589, ; 144: SQLitePCLRaw.nativelibrary => 0x38c3d6bd => 197
	i32 956575887, ; 145: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 302
	i32 966729478, ; 146: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 293
	i32 967690846, ; 147: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 255
	i32 975236339, ; 148: System.Diagnostics.Tracing => 0x3a20ecf3 => 34
	i32 975874589, ; 149: System.Xml.XDocument => 0x3a2aaa1d => 158
	i32 986514023, ; 150: System.Private.DataContractSerialization.dll => 0x3acd0267 => 85
	i32 987214855, ; 151: System.Diagnostics.Tools => 0x3ad7b407 => 32
	i32 992768348, ; 152: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 153: System.IO.FileSystem => 0x3b45fb35 => 51
	i32 1001831731, ; 154: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 56
	i32 1012816738, ; 155: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 276
	i32 1019214401, ; 156: System.Drawing => 0x3cbffa41 => 36
	i32 1028013380, ; 157: ExoPlayer.UI.dll => 0x3d463d44 => 218
	i32 1028951442, ; 158: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 181
	i32 1029334545, ; 159: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 308
	i32 1031528504, ; 160: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 294
	i32 1035644815, ; 161: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 228
	i32 1036536393, ; 162: System.Drawing.Primitives.dll => 0x3dc84a49 => 35
	i32 1044663988, ; 163: System.Linq.Expressions.dll => 0x3e444eb4 => 58
	i32 1052210849, ; 164: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 262
	i32 1067306892, ; 165: GoogleGson => 0x3f9dcf8c => 177
	i32 1082857460, ; 166: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 167: Xamarin.Kotlin.StdLib => 0x409e66d8 => 299
	i32 1098259244, ; 168: System => 0x41761b2c => 164
	i32 1118262833, ; 169: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 321
	i32 1121599056, ; 170: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 261
	i32 1127624469, ; 171: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 184
	i32 1149092582, ; 172: Xamarin.AndroidX.Window => 0x447dc2e6 => 289
	i32 1151313727, ; 173: ExoPlayer.Rtsp => 0x449fa73f => 215
	i32 1168523401, ; 174: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 327
	i32 1170634674, ; 175: System.Web.dll => 0x45c677b2 => 153
	i32 1175144683, ; 176: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 285
	i32 1178241025, ; 177: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 270
	i32 1203215381, ; 178: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 325
	i32 1204270330, ; 179: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 230
	i32 1208641965, ; 180: System.Diagnostics.Process => 0x480a69ad => 29
	i32 1214827643, ; 181: CommunityToolkit.Mvvm => 0x4868cc7b => 176
	i32 1219128291, ; 182: System.IO.IsolatedStorage => 0x48aa6be3 => 52
	i32 1234928153, ; 183: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 323
	i32 1243150071, ; 184: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 290
	i32 1253011324, ; 185: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 186: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 307
	i32 1263886435, ; 187: Xamarin.Google.Guava.dll => 0x4b556063 => 295
	i32 1264511973, ; 188: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 280
	i32 1267360935, ; 189: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 284
	i32 1273260888, ; 190: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 235
	i32 1275534314, ; 191: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 303
	i32 1278448581, ; 192: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 227
	i32 1292207520, ; 193: SQLitePCLRaw.core.dll => 0x4d0585a0 => 198
	i32 1293217323, ; 194: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 246
	i32 1309188875, ; 195: System.Private.DataContractSerialization => 0x4e08a30b => 85
	i32 1309209905, ; 196: ExoPlayer.DataSource => 0x4e08f531 => 210
	i32 1322716291, ; 197: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 289
	i32 1324164729, ; 198: System.Linq => 0x4eed2679 => 61
	i32 1335329327, ; 199: System.Runtime.Serialization.Json.dll => 0x4f97822f => 112
	i32 1347751866, ; 200: Plugin.Maui.Audio => 0x50550fba => 193
	i32 1364015309, ; 201: System.IO => 0x514d38cd => 57
	i32 1373134921, ; 202: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 337
	i32 1376866003, ; 203: Xamarin.AndroidX.SavedState => 0x52114ed3 => 276
	i32 1379779777, ; 204: System.Resources.ResourceManager => 0x523dc4c1 => 99
	i32 1395857551, ; 205: Xamarin.AndroidX.Media.dll => 0x5333188f => 267
	i32 1402170036, ; 206: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 207: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 239
	i32 1406299041, ; 208: Xamarin.Google.Guava.FailureAccess => 0x53d26ba1 => 296
	i32 1408764838, ; 209: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 111
	i32 1411638395, ; 210: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 101
	i32 1422545099, ; 211: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 102
	i32 1430672901, ; 212: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 305
	i32 1434145427, ; 213: System.Runtime.Handles => 0x557b5293 => 104
	i32 1435222561, ; 214: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 293
	i32 1439761251, ; 215: System.Net.Quic.dll => 0x55d10363 => 71
	i32 1452070440, ; 216: System.Formats.Asn1.dll => 0x568cd628 => 38
	i32 1453312822, ; 217: System.Diagnostics.Tools.dll => 0x569fcb36 => 32
	i32 1457743152, ; 218: System.Runtime.Extensions.dll => 0x56e36530 => 103
	i32 1458022317, ; 219: System.Net.Security.dll => 0x56e7a7ad => 73
	i32 1461004990, ; 220: es\Microsoft.Maui.Controls.resources => 0x57152abe => 311
	i32 1461234159, ; 221: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 222: System.Security.Cryptography.OpenSsl => 0x57201017 => 123
	i32 1462112819, ; 223: System.IO.Compression.dll => 0x57261233 => 46
	i32 1469204771, ; 224: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 229
	i32 1470490898, ; 225: Microsoft.Extensions.Primitives => 0x57a5e912 => 186
	i32 1479771757, ; 226: System.Collections.Immutable => 0x5833866d => 9
	i32 1480156764, ; 227: ExoPlayer.DataSource.dll => 0x5839665c => 210
	i32 1480492111, ; 228: System.IO.Compression.Brotli.dll => 0x583e844f => 43
	i32 1487239319, ; 229: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 230: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 277
	i32 1493001747, ; 231: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 315
	i32 1514721132, ; 232: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 310
	i32 1536373174, ; 233: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 31
	i32 1543031311, ; 234: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 138
	i32 1543355203, ; 235: System.Reflection.Emit.dll => 0x5bfdbb43 => 92
	i32 1550322496, ; 236: System.Reflection.Extensions.dll => 0x5c680b40 => 93
	i32 1551623176, ; 237: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 330
	i32 1565862583, ; 238: System.IO.FileSystem.Primitives => 0x5d552ab7 => 49
	i32 1566207040, ; 239: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 141
	i32 1573704789, ; 240: System.Runtime.Serialization.Json => 0x5dccd455 => 112
	i32 1580037396, ; 241: System.Threading.Overlapped => 0x5e2d7514 => 140
	i32 1582372066, ; 242: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 245
	i32 1592978981, ; 243: System.Runtime.Serialization.dll => 0x5ef2ee25 => 115
	i32 1597949149, ; 244: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 294
	i32 1601112923, ; 245: System.Xml.Serialization => 0x5f6f0b5b => 157
	i32 1604827217, ; 246: System.Net.WebClient => 0x5fa7b851 => 76
	i32 1618516317, ; 247: System.Net.WebSockets.Client.dll => 0x6078995d => 79
	i32 1622152042, ; 248: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 265
	i32 1622358360, ; 249: System.Dynamic.Runtime => 0x60b33958 => 37
	i32 1624863272, ; 250: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 288
	i32 1634654947, ; 251: CommunityToolkit.Maui.Core.dll => 0x616edae3 => 174
	i32 1635184631, ; 252: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 249
	i32 1636350590, ; 253: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 242
	i32 1638652436, ; 254: CommunityToolkit.Maui.MediaElement => 0x61abda14 => 175
	i32 1639515021, ; 255: System.Net.Http.dll => 0x61b9038d => 64
	i32 1639986890, ; 256: System.Text.RegularExpressions => 0x61c036ca => 138
	i32 1641389582, ; 257: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 258: System.Runtime => 0x62c6282e => 116
	i32 1658241508, ; 259: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 282
	i32 1658251792, ; 260: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 291
	i32 1670060433, ; 261: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 237
	i32 1675553242, ; 262: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 48
	i32 1677501392, ; 263: System.Net.Primitives.dll => 0x63fca3d0 => 70
	i32 1678508291, ; 264: System.Net.WebSockets => 0x640c0103 => 80
	i32 1679769178, ; 265: System.Security.Cryptography => 0x641f3e5a => 126
	i32 1691477237, ; 266: System.Reflection.Metadata => 0x64d1e4f5 => 94
	i32 1696967625, ; 267: System.Security.Cryptography.Csp => 0x6525abc9 => 121
	i32 1698840827, ; 268: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 300
	i32 1700397376, ; 269: ExoPlayer.Transformer => 0x655a0140 => 217
	i32 1701541528, ; 270: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1711441057, ; 271: SQLitePCLRaw.lib.e_sqlite3.android => 0x660284a1 => 199
	i32 1716915175, ; 272: Course.dll => 0x66560be7 => 0
	i32 1720223769, ; 273: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 258
	i32 1726116996, ; 274: System.Reflection.dll => 0x66e27484 => 97
	i32 1728033016, ; 275: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 28
	i32 1729485958, ; 276: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 233
	i32 1736233607, ; 277: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 328
	i32 1743415430, ; 278: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 306
	i32 1744735666, ; 279: System.Transactions.Local.dll => 0x67fe8db2 => 149
	i32 1746316138, ; 280: Mono.Android.Export => 0x6816ab6a => 169
	i32 1750313021, ; 281: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 282: System.Resources.Reader.dll => 0x68cc9d1e => 98
	i32 1763938596, ; 283: System.Diagnostics.TraceSource.dll => 0x69239124 => 33
	i32 1765620304, ; 284: ExoPlayer.Core => 0x693d3a50 => 207
	i32 1765942094, ; 285: System.Reflection.Extensions => 0x6942234e => 93
	i32 1766324549, ; 286: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 281
	i32 1770582343, ; 287: Microsoft.Extensions.Logging.dll => 0x6988f147 => 182
	i32 1776026572, ; 288: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 289: System.Globalization.Extensions.dll => 0x69ec0683 => 41
	i32 1780572499, ; 290: Mono.Android.Runtime.dll => 0x6a216153 => 170
	i32 1782862114, ; 291: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 322
	i32 1788241197, ; 292: Xamarin.AndroidX.Fragment => 0x6a96652d => 251
	i32 1793755602, ; 293: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 314
	i32 1808609942, ; 294: Xamarin.AndroidX.Loader => 0x6bcd3296 => 265
	i32 1813058853, ; 295: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 299
	i32 1813201214, ; 296: Xamarin.Google.Android.Material => 0x6c13413e => 291
	i32 1818569960, ; 297: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 271
	i32 1818787751, ; 298: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 299: System.Text.Encoding.Extensions => 0x6cbab720 => 134
	i32 1824722060, ; 300: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 111
	i32 1828688058, ; 301: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 183
	i32 1842015223, ; 302: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 334
	i32 1847515442, ; 303: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 220
	i32 1853025655, ; 304: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 331
	i32 1858542181, ; 305: System.Linq.Expressions => 0x6ec71a65 => 58
	i32 1870277092, ; 306: System.Reflection.Primitives => 0x6f7a29e4 => 95
	i32 1875935024, ; 307: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 313
	i32 1879696579, ; 308: System.Formats.Tar.dll => 0x7009e4c3 => 39
	i32 1885316902, ; 309: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 231
	i32 1888955245, ; 310: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 311: System.Reflection.Metadata.dll => 0x70a66bdd => 94
	i32 1898237753, ; 312: System.Reflection.DispatchProxy => 0x7124cf39 => 89
	i32 1900610850, ; 313: System.Resources.ResourceManager.dll => 0x71490522 => 99
	i32 1910275211, ; 314: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1926145099, ; 315: ExoPlayer.Container.dll => 0x72cea44b => 206
	i32 1939592360, ; 316: System.Private.Xml.Linq => 0x739bd4a8 => 87
	i32 1956758971, ; 317: System.Resources.Writer => 0x74a1c5bb => 100
	i32 1961813231, ; 318: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 278
	i32 1968388702, ; 319: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 178
	i32 1983156543, ; 320: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 300
	i32 1984283898, ; 321: ExoPlayer.Ext.MediaSession.dll => 0x7645c4fa => 214
	i32 1985761444, ; 322: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 222
	i32 2003115576, ; 323: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 310
	i32 2011961780, ; 324: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 325: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 262
	i32 2025202353, ; 326: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 305
	i32 2031763787, ; 327: Xamarin.Android.Glide => 0x791a414b => 219
	i32 2045470958, ; 328: System.Private.Xml => 0x79eb68ee => 88
	i32 2055257422, ; 329: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 257
	i32 2060060697, ; 330: System.Windows.dll => 0x7aca0819 => 154
	i32 2066184531, ; 331: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 309
	i32 2070888862, ; 332: System.Diagnostics.TraceSource => 0x7b6f419e => 33
	i32 2079903147, ; 333: System.Runtime.dll => 0x7bf8cdab => 116
	i32 2090495875, ; 334: SQLitePCLRaw.provider.dynamic_cdecl => 0x7c9a6f83 => 200
	i32 2090596640, ; 335: System.Numerics.Vectors => 0x7c9bf920 => 82
	i32 2103459038, ; 336: SQLitePCLRaw.provider.e_sqlite3.dll => 0x7d603cde => 201
	i32 2106312818, ; 337: ExoPlayer.Decoder => 0x7d8bc872 => 211
	i32 2113912252, ; 338: ExoPlayer.UI => 0x7dffbdbc => 218
	i32 2127167465, ; 339: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 340: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 341: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 162
	i32 2146852085, ; 342: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 343: Microsoft.Maui => 0x80bd55ad => 190
	i32 2169148018, ; 344: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 317
	i32 2181898931, ; 345: Microsoft.Extensions.Options.dll => 0x820d22b3 => 185
	i32 2192057212, ; 346: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 183
	i32 2193016926, ; 347: System.ObjectModel.dll => 0x82b6c85e => 84
	i32 2201107256, ; 348: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 304
	i32 2201231467, ; 349: System.Net.Http => 0x8334206b => 64
	i32 2202964214, ; 350: ExoPlayer.dll => 0x834e90f6 => 204
	i32 2207618523, ; 351: it\Microsoft.Maui.Controls.resources => 0x839595db => 319
	i32 2217644978, ; 352: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 285
	i32 2222056684, ; 353: System.Threading.Tasks.Parallel => 0x8471e4ec => 143
	i32 2239138732, ; 354: ExoPlayer.SmoothStreaming => 0x85768bac => 216
	i32 2241603124, ; 355: Course => 0x859c2634 => 0
	i32 2244775296, ; 356: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 266
	i32 2252106437, ; 357: System.Xml.Serialization.dll => 0x863c6ac5 => 157
	i32 2256313426, ; 358: System.Globalization.Extensions => 0x867c9c52 => 41
	i32 2265110946, ; 359: System.Security.AccessControl.dll => 0x8702d9a2 => 117
	i32 2266799131, ; 360: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 179
	i32 2267999099, ; 361: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 221
	i32 2270573516, ; 362: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 313
	i32 2279755925, ; 363: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 274
	i32 2293034957, ; 364: System.ServiceModel.Web.dll => 0x88acefcd => 131
	i32 2295906218, ; 365: System.Net.Sockets => 0x88d8bfaa => 75
	i32 2298471582, ; 366: System.Net.Mail => 0x88ffe49e => 66
	i32 2303942373, ; 367: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 323
	i32 2305521784, ; 368: System.Private.CoreLib.dll => 0x896b7878 => 172
	i32 2315684594, ; 369: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 225
	i32 2320631194, ; 370: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 143
	i32 2340441535, ; 371: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 106
	i32 2344264397, ; 372: System.ValueTuple => 0x8bbaa2cd => 151
	i32 2353062107, ; 373: System.Net.Primitives => 0x8c40e0db => 70
	i32 2354730003, ; 374: Syncfusion.Licensing => 0x8c5a5413 => 202
	i32 2368005991, ; 375: System.Xml.ReaderWriter.dll => 0x8d24e767 => 156
	i32 2371007202, ; 376: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 178
	i32 2378619854, ; 377: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 121
	i32 2383496789, ; 378: System.Security.Principal.Windows.dll => 0x8e114655 => 127
	i32 2395872292, ; 379: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 318
	i32 2401565422, ; 380: System.Web.HttpUtility => 0x8f24faee => 152
	i32 2403452196, ; 381: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 248
	i32 2421380589, ; 382: System.Threading.Tasks.Dataflow => 0x905355ed => 141
	i32 2423080555, ; 383: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 235
	i32 2427813419, ; 384: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 315
	i32 2435356389, ; 385: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 386: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2437192331, ; 387: CommunityToolkit.Maui.MediaElement.dll => 0x91449a8b => 175
	i32 2454642406, ; 388: System.Text.Encoding.dll => 0x924edee6 => 135
	i32 2458678730, ; 389: System.Net.Sockets.dll => 0x928c75ca => 75
	i32 2459001652, ; 390: System.Linq.Parallel.dll => 0x92916334 => 59
	i32 2465273461, ; 391: SQLitePCLRaw.batteries_v2.dll => 0x92f11675 => 196
	i32 2465532216, ; 392: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 238
	i32 2471841756, ; 393: netstandard.dll => 0x93554fdc => 167
	i32 2475788418, ; 394: Java.Interop.dll => 0x93918882 => 168
	i32 2476233210, ; 395: ExoPlayer => 0x939851fa => 204
	i32 2480646305, ; 396: Microsoft.Maui.Controls => 0x93dba8a1 => 188
	i32 2483903535, ; 397: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 398: System.Net.ServicePoint => 0x94147f61 => 74
	i32 2490993605, ; 399: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 400: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 401: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 260
	i32 2515854816, ; 402: ExoPlayer.Common => 0x95f4e5e0 => 205
	i32 2522472828, ; 403: Xamarin.Android.Glide.dll => 0x9659e17c => 219
	i32 2538310050, ; 404: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 91
	i32 2550873716, ; 405: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 316
	i32 2562349572, ; 406: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 407: System.Text.Encodings.Web => 0x9930ee42 => 136
	i32 2581783588, ; 408: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 261
	i32 2581819634, ; 409: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 284
	i32 2585220780, ; 410: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 134
	i32 2585805581, ; 411: System.Net.Ping => 0x9a20430d => 69
	i32 2589602615, ; 412: System.Threading.ThreadPool => 0x9a5a3337 => 146
	i32 2593496499, ; 413: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 325
	i32 2605712449, ; 414: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 304
	i32 2615233544, ; 415: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 252
	i32 2616218305, ; 416: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 184
	i32 2617129537, ; 417: System.Private.Xml.dll => 0x9bfe3a41 => 88
	i32 2618712057, ; 418: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 96
	i32 2620871830, ; 419: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 242
	i32 2624644809, ; 420: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 247
	i32 2626028643, ; 421: ExoPlayer.Rtsp.dll => 0x9c860463 => 215
	i32 2626831493, ; 422: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 320
	i32 2627185994, ; 423: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 31
	i32 2629843544, ; 424: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 45
	i32 2633051222, ; 425: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 256
	i32 2663391936, ; 426: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 221
	i32 2663698177, ; 427: System.Runtime.Loader => 0x9ec4cf01 => 109
	i32 2664396074, ; 428: System.Xml.XDocument.dll => 0x9ecf752a => 158
	i32 2665622720, ; 429: System.Drawing.Primitives => 0x9ee22cc0 => 35
	i32 2676780864, ; 430: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 431: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 114
	i32 2693849962, ; 432: System.IO.dll => 0xa090e36a => 57
	i32 2701096212, ; 433: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 282
	i32 2713040075, ; 434: ExoPlayer.Hls => 0xa1b5b4cb => 213
	i32 2715334215, ; 435: System.Threading.Tasks.dll => 0xa1d8b647 => 144
	i32 2717744543, ; 436: System.Security.Claims => 0xa1fd7d9f => 118
	i32 2719963679, ; 437: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 120
	i32 2724373263, ; 438: System.Runtime.Numerics.dll => 0xa262a30f => 110
	i32 2732626843, ; 439: Xamarin.AndroidX.Activity => 0xa2e0939b => 223
	i32 2735172069, ; 440: System.Threading.Channels => 0xa30769e5 => 139
	i32 2737747696, ; 441: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 229
	i32 2740948882, ; 442: System.IO.Pipes.AccessControl => 0xa35f8f92 => 54
	i32 2748088231, ; 443: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 105
	i32 2752995522, ; 444: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 326
	i32 2754540824, ; 445: SQLitePCLRaw.nativelibrary.dll => 0xa42ef518 => 197
	i32 2758225723, ; 446: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 189
	i32 2764765095, ; 447: Microsoft.Maui.dll => 0xa4caf7a7 => 190
	i32 2765824710, ; 448: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 133
	i32 2770495804, ; 449: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 298
	i32 2778768386, ; 450: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 287
	i32 2779977773, ; 451: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 275
	i32 2785988530, ; 452: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 332
	i32 2788224221, ; 453: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 252
	i32 2796087574, ; 454: ExoPlayer.Extractor.dll => 0xa6a8e916 => 212
	i32 2801831435, ; 455: Microsoft.Maui.Graphics => 0xa7008e0b => 192
	i32 2803228030, ; 456: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 159
	i32 2806116107, ; 457: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 311
	i32 2810250172, ; 458: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 239
	i32 2819470561, ; 459: System.Xml.dll => 0xa80db4e1 => 163
	i32 2821205001, ; 460: System.ServiceProcess.dll => 0xa8282c09 => 132
	i32 2821294376, ; 461: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 275
	i32 2824502124, ; 462: System.Xml.XmlDocument => 0xa85a7b6c => 161
	i32 2831556043, ; 463: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 324
	i32 2838993487, ; 464: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 263
	i32 2849599387, ; 465: System.Threading.Overlapped.dll => 0xa9d96f9b => 140
	i32 2853208004, ; 466: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 287
	i32 2855708567, ; 467: Xamarin.AndroidX.Transition => 0xaa36a797 => 283
	i32 2861098320, ; 468: Mono.Android.Export.dll => 0xaa88e550 => 169
	i32 2861189240, ; 469: Microsoft.Maui.Essentials => 0xaa8a4878 => 191
	i32 2868488919, ; 470: CommunityToolkit.Maui.Core => 0xaaf9aad7 => 174
	i32 2868557005, ; 471: Syncfusion.Licensing.dll => 0xaafab4cd => 202
	i32 2870099610, ; 472: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 224
	i32 2875164099, ; 473: Jsr305Binding.dll => 0xab5f85c3 => 292
	i32 2875220617, ; 474: System.Globalization.Calendars.dll => 0xab606289 => 40
	i32 2884993177, ; 475: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 250
	i32 2887636118, ; 476: System.Net.dll => 0xac1dd496 => 81
	i32 2899753641, ; 477: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 56
	i32 2900621748, ; 478: System.Dynamic.Runtime.dll => 0xace3f9b4 => 37
	i32 2901442782, ; 479: System.Reflection => 0xacf080de => 97
	i32 2905242038, ; 480: mscorlib.dll => 0xad2a79b6 => 166
	i32 2909740682, ; 481: System.Private.CoreLib => 0xad6f1e8a => 172
	i32 2916838712, ; 482: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 288
	i32 2919462931, ; 483: System.Numerics.Vectors.dll => 0xae037813 => 82
	i32 2921128767, ; 484: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 226
	i32 2936416060, ; 485: System.Resources.Reader => 0xaf06273c => 98
	i32 2940926066, ; 486: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 30
	i32 2942453041, ; 487: System.Xml.XPath.XDocument => 0xaf624531 => 159
	i32 2959614098, ; 488: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2960379616, ; 489: Xamarin.Google.Guava => 0xb073cee0 => 295
	i32 2968338931, ; 490: System.Security.Principal.Windows => 0xb0ed41f3 => 127
	i32 2972252294, ; 491: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 119
	i32 2978675010, ; 492: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 246
	i32 2987532451, ; 493: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 278
	i32 2996846495, ; 494: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 259
	i32 3016983068, ; 495: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 280
	i32 3023353419, ; 496: WindowsBase.dll => 0xb434b64b => 165
	i32 3024354802, ; 497: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 254
	i32 3027462113, ; 498: ExoPlayer.Common.dll => 0xb47367e1 => 205
	i32 3038032645, ; 499: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 339
	i32 3056245963, ; 500: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 277
	i32 3057625584, ; 501: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 268
	i32 3059408633, ; 502: Mono.Android.Runtime => 0xb65adef9 => 170
	i32 3059793426, ; 503: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 504: System.Threading.Tasks => 0xb755818f => 144
	i32 3077302341, ; 505: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 317
	i32 3090735792, ; 506: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 125
	i32 3099732863, ; 507: System.Security.Claims.dll => 0xb8c22b7f => 118
	i32 3103600923, ; 508: System.Formats.Asn1 => 0xb8fd311b => 38
	i32 3111772706, ; 509: System.Runtime.Serialization => 0xb979e222 => 115
	i32 3121463068, ; 510: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 47
	i32 3124832203, ; 511: System.Threading.Tasks.Extensions => 0xba4127cb => 142
	i32 3132293585, ; 512: System.Security.AccessControl => 0xbab301d1 => 117
	i32 3144327419, ; 513: ExoPlayer.Hls.dll => 0xbb6aa0fb => 213
	i32 3147165239, ; 514: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 34
	i32 3147228406, ; 515: Syncfusion.Maui.Core => 0xbb96e4f6 => 203
	i32 3148237826, ; 516: GoogleGson.dll => 0xbba64c02 => 177
	i32 3159123045, ; 517: System.Reflection.Primitives.dll => 0xbc4c6465 => 95
	i32 3160747431, ; 518: System.IO.MemoryMappedFiles => 0xbc652da7 => 53
	i32 3178803400, ; 519: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 269
	i32 3190271366, ; 520: ExoPlayer.Decoder.dll => 0xbe27ad86 => 211
	i32 3192346100, ; 521: System.Security.SecureString => 0xbe4755f4 => 129
	i32 3193515020, ; 522: System.Web => 0xbe592c0c => 153
	i32 3204380047, ; 523: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 524: System.Xml.XmlDocument.dll => 0xbf506931 => 161
	i32 3211777861, ; 525: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 245
	i32 3220365878, ; 526: System.Threading => 0xbff2e236 => 148
	i32 3226221578, ; 527: System.Runtime.Handles.dll => 0xc04c3c0a => 104
	i32 3251039220, ; 528: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 89
	i32 3257332390, ; 529: MvvmHelpers => 0xc226f2a6 => 194
	i32 3258312781, ; 530: Xamarin.AndroidX.CardView => 0xc235e84d => 233
	i32 3265493905, ; 531: System.Linq.Queryable.dll => 0xc2a37b91 => 60
	i32 3265893370, ; 532: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 142
	i32 3277815716, ; 533: System.Resources.Writer.dll => 0xc35f7fa4 => 100
	i32 3279906254, ; 534: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 535: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3286872994, ; 536: SQLite-net.dll => 0xc3e9b3a2 => 195
	i32 3290767353, ; 537: System.Security.Cryptography.Encoding => 0xc4251ff9 => 122
	i32 3299363146, ; 538: System.Text.Encoding => 0xc4a8494a => 135
	i32 3303498502, ; 539: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 28
	i32 3305363605, ; 540: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 312
	i32 3316684772, ; 541: System.Net.Requests.dll => 0xc5b097e4 => 72
	i32 3317135071, ; 542: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 243
	i32 3317144872, ; 543: System.Data => 0xc5b79d28 => 24
	i32 3329734229, ; 544: ExoPlayer.Database => 0xc677b655 => 209
	i32 3340431453, ; 545: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 231
	i32 3345895724, ; 546: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 273
	i32 3346324047, ; 547: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 270
	i32 3357674450, ; 548: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 329
	i32 3358260929, ; 549: System.Text.Json => 0xc82afec1 => 137
	i32 3360279109, ; 550: SQLitePCLRaw.core => 0xc849ca45 => 198
	i32 3362336904, ; 551: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 224
	i32 3362522851, ; 552: Xamarin.AndroidX.Core => 0xc86c06e3 => 240
	i32 3366347497, ; 553: Java.Interop => 0xc8a662e9 => 168
	i32 3374999561, ; 554: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 274
	i32 3381016424, ; 555: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 308
	i32 3395150330, ; 556: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 101
	i32 3396979385, ; 557: ExoPlayer.Transformer.dll => 0xca79cab9 => 217
	i32 3403906625, ; 558: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 123
	i32 3405233483, ; 559: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 244
	i32 3428513518, ; 560: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 180
	i32 3429136800, ; 561: System.Xml => 0xcc6479a0 => 163
	i32 3430777524, ; 562: netstandard => 0xcc7d82b4 => 167
	i32 3441283291, ; 563: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 247
	i32 3445260447, ; 564: System.Formats.Tar => 0xcd5a809f => 39
	i32 3452344032, ; 565: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 187
	i32 3463511458, ; 566: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 316
	i32 3471940407, ; 567: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3476120550, ; 568: Mono.Android => 0xcf3163e6 => 171
	i32 3479583265, ; 569: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 329
	i32 3484440000, ; 570: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 328
	i32 3485117614, ; 571: System.Text.Json.dll => 0xcfbaacae => 137
	i32 3486566296, ; 572: System.Transactions => 0xcfd0c798 => 150
	i32 3493954962, ; 573: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 236
	i32 3509114376, ; 574: System.Xml.Linq => 0xd128d608 => 155
	i32 3515174580, ; 575: System.Security.dll => 0xd1854eb4 => 130
	i32 3530912306, ; 576: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 577: System.Net.HttpListener => 0xd2ff69f1 => 65
	i32 3560100363, ; 578: System.Threading.Timer => 0xd432d20b => 147
	i32 3570554715, ; 579: System.IO.FileSystem.AccessControl => 0xd4d2575b => 47
	i32 3580758918, ; 580: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 336
	i32 3597029428, ; 581: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 222
	i32 3598340787, ; 582: System.Net.WebSockets.Client => 0xd67a52b3 => 79
	i32 3608519521, ; 583: System.Linq.dll => 0xd715a361 => 61
	i32 3624195450, ; 584: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 106
	i32 3627220390, ; 585: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 272
	i32 3633644679, ; 586: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 226
	i32 3638274909, ; 587: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 49
	i32 3641597786, ; 588: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 257
	i32 3643446276, ; 589: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 333
	i32 3643854240, ; 590: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 269
	i32 3645089577, ; 591: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 592: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 179
	i32 3660523487, ; 593: System.Net.NetworkInformation => 0xda2f27df => 68
	i32 3660726404, ; 594: Plugin.Maui.Audio.dll => 0xda324084 => 193
	i32 3672681054, ; 595: Mono.Android.dll => 0xdae8aa5e => 171
	i32 3682565725, ; 596: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 232
	i32 3684561358, ; 597: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 236
	i32 3697841164, ; 598: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 338
	i32 3700866549, ; 599: System.Net.WebProxy.dll => 0xdc96bdf5 => 78
	i32 3706696989, ; 600: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 241
	i32 3716563718, ; 601: System.Runtime.Intrinsics => 0xdd864306 => 108
	i32 3718780102, ; 602: Xamarin.AndroidX.Annotation => 0xdda814c6 => 225
	i32 3724971120, ; 603: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 268
	i32 3732100267, ; 604: System.Net.NameResolution => 0xde7354ab => 67
	i32 3737834244, ; 605: System.Net.Http.Json.dll => 0xdecad304 => 63
	i32 3748608112, ; 606: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 27
	i32 3751444290, ; 607: System.Xml.XPath => 0xdf9a7f42 => 160
	i32 3754567612, ; 608: SQLitePCLRaw.provider.e_sqlite3 => 0xdfca27bc => 201
	i32 3786282454, ; 609: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 234
	i32 3792276235, ; 610: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3800979733, ; 611: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 187
	i32 3802395368, ; 612: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3817368567, ; 613: CommunityToolkit.Maui.dll => 0xe3886bf7 => 173
	i32 3819260425, ; 614: System.Net.WebProxy => 0xe3a54a09 => 78
	i32 3822602673, ; 615: Xamarin.AndroidX.Media => 0xe3d849b1 => 267
	i32 3823082795, ; 616: System.Security.Cryptography.dll => 0xe3df9d2b => 126
	i32 3829621856, ; 617: System.Numerics.dll => 0xe4436460 => 83
	i32 3841636137, ; 618: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 181
	i32 3844307129, ; 619: System.Net.Mail.dll => 0xe52378b9 => 66
	i32 3849253459, ; 620: System.Runtime.InteropServices.dll => 0xe56ef253 => 107
	i32 3870376305, ; 621: System.Net.HttpListener.dll => 0xe6b14171 => 65
	i32 3873536506, ; 622: System.Security.Principal => 0xe6e179fa => 128
	i32 3875112723, ; 623: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 122
	i32 3876362041, ; 624: SQLite-net => 0xe70c9739 => 195
	i32 3885497537, ; 625: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 77
	i32 3885922214, ; 626: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 283
	i32 3888767677, ; 627: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 273
	i32 3889960447, ; 628: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 337
	i32 3896106733, ; 629: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 630: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 240
	i32 3901907137, ; 631: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 632: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 44
	i32 3921031405, ; 633: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 286
	i32 3928044579, ; 634: System.Xml.ReaderWriter => 0xea213423 => 156
	i32 3930554604, ; 635: System.Security.Principal.dll => 0xea4780ec => 128
	i32 3931092270, ; 636: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 271
	i32 3945713374, ; 637: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 638: System.Text.Encoding.CodePages => 0xebac8bfe => 133
	i32 3955647286, ; 639: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 228
	i32 3959773229, ; 640: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 259
	i32 3980434154, ; 641: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 332
	i32 3987592930, ; 642: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 314
	i32 4003436829, ; 643: System.Diagnostics.Process.dll => 0xee9f991d => 29
	i32 4015948917, ; 644: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 227
	i32 4025784931, ; 645: System.Memory => 0xeff49a63 => 62
	i32 4046471985, ; 646: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 189
	i32 4054681211, ; 647: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 90
	i32 4068434129, ; 648: System.Private.Xml.Linq.dll => 0xf27f60d1 => 87
	i32 4073602200, ; 649: System.Threading.dll => 0xf2ce3c98 => 148
	i32 4094352644, ; 650: Microsoft.Maui.Essentials.dll => 0xf40add04 => 191
	i32 4099507663, ; 651: System.Drawing.dll => 0xf45985cf => 36
	i32 4100113165, ; 652: System.Private.Uri => 0xf462c30d => 86
	i32 4101593132, ; 653: Xamarin.AndroidX.Emoji2 => 0xf479582c => 248
	i32 4102112229, ; 654: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 327
	i32 4125707920, ; 655: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 322
	i32 4126470640, ; 656: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 180
	i32 4127667938, ; 657: System.IO.FileSystem.Watcher => 0xf60736e2 => 50
	i32 4130442656, ; 658: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 659: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 90
	i32 4150914736, ; 660: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 334
	i32 4151237749, ; 661: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 662: System.Xml.XmlSerializer => 0xf7e95c85 => 162
	i32 4161255271, ; 663: System.Reflection.TypeExtensions => 0xf807b767 => 96
	i32 4164802419, ; 664: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 50
	i32 4173364138, ; 665: ExoPlayer.SmoothStreaming.dll => 0xf8c07baa => 216
	i32 4181436372, ; 666: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 113
	i32 4182413190, ; 667: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 264
	i32 4185676441, ; 668: System.Security => 0xf97c5a99 => 130
	i32 4190597220, ; 669: ExoPlayer.Core.dll => 0xf9c77064 => 207
	i32 4196529839, ; 670: System.Net.WebClient.dll => 0xfa21f6af => 76
	i32 4213026141, ; 671: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 27
	i32 4256097574, ; 672: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 241
	i32 4258378803, ; 673: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 263
	i32 4260525087, ; 674: System.Buffers => 0xfdf2741f => 7
	i32 4271975918, ; 675: Microsoft.Maui.Controls.dll => 0xfea12dee => 188
	i32 4274623895, ; 676: CommunityToolkit.Mvvm.dll => 0xfec99597 => 176
	i32 4274976490, ; 677: System.Runtime.Numerics => 0xfecef6ea => 110
	i32 4292120959, ; 678: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 264
	i32 4294763496 ; 679: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 250
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [680 x i32] [
	i32 68, ; 0
	i32 67, ; 1
	i32 108, ; 2
	i32 260, ; 3
	i32 297, ; 4
	i32 48, ; 5
	i32 80, ; 6
	i32 145, ; 7
	i32 30, ; 8
	i32 338, ; 9
	i32 124, ; 10
	i32 192, ; 11
	i32 102, ; 12
	i32 279, ; 13
	i32 107, ; 14
	i32 279, ; 15
	i32 139, ; 16
	i32 301, ; 17
	i32 77, ; 18
	i32 124, ; 19
	i32 13, ; 20
	i32 234, ; 21
	i32 203, ; 22
	i32 132, ; 23
	i32 281, ; 24
	i32 151, ; 25
	i32 335, ; 26
	i32 336, ; 27
	i32 18, ; 28
	i32 232, ; 29
	i32 26, ; 30
	i32 254, ; 31
	i32 1, ; 32
	i32 59, ; 33
	i32 42, ; 34
	i32 91, ; 35
	i32 237, ; 36
	i32 296, ; 37
	i32 147, ; 38
	i32 256, ; 39
	i32 253, ; 40
	i32 307, ; 41
	i32 54, ; 42
	i32 208, ; 43
	i32 69, ; 44
	i32 335, ; 45
	i32 223, ; 46
	i32 83, ; 47
	i32 320, ; 48
	i32 255, ; 49
	i32 199, ; 50
	i32 319, ; 51
	i32 131, ; 52
	i32 55, ; 53
	i32 149, ; 54
	i32 74, ; 55
	i32 145, ; 56
	i32 62, ; 57
	i32 146, ; 58
	i32 339, ; 59
	i32 165, ; 60
	i32 331, ; 61
	i32 238, ; 62
	i32 12, ; 63
	i32 251, ; 64
	i32 125, ; 65
	i32 209, ; 66
	i32 152, ; 67
	i32 113, ; 68
	i32 166, ; 69
	i32 164, ; 70
	i32 253, ; 71
	i32 266, ; 72
	i32 84, ; 73
	i32 318, ; 74
	i32 312, ; 75
	i32 186, ; 76
	i32 150, ; 77
	i32 301, ; 78
	i32 60, ; 79
	i32 182, ; 80
	i32 51, ; 81
	i32 103, ; 82
	i32 114, ; 83
	i32 40, ; 84
	i32 292, ; 85
	i32 290, ; 86
	i32 120, ; 87
	i32 326, ; 88
	i32 173, ; 89
	i32 52, ; 90
	i32 44, ; 91
	i32 119, ; 92
	i32 206, ; 93
	i32 243, ; 94
	i32 324, ; 95
	i32 249, ; 96
	i32 81, ; 97
	i32 136, ; 98
	i32 286, ; 99
	i32 230, ; 100
	i32 8, ; 101
	i32 73, ; 102
	i32 306, ; 103
	i32 155, ; 104
	i32 303, ; 105
	i32 154, ; 106
	i32 92, ; 107
	i32 298, ; 108
	i32 45, ; 109
	i32 321, ; 110
	i32 309, ; 111
	i32 302, ; 112
	i32 109, ; 113
	i32 129, ; 114
	i32 196, ; 115
	i32 25, ; 116
	i32 200, ; 117
	i32 220, ; 118
	i32 72, ; 119
	i32 55, ; 120
	i32 46, ; 121
	i32 330, ; 122
	i32 185, ; 123
	i32 244, ; 124
	i32 22, ; 125
	i32 258, ; 126
	i32 208, ; 127
	i32 86, ; 128
	i32 43, ; 129
	i32 160, ; 130
	i32 71, ; 131
	i32 194, ; 132
	i32 272, ; 133
	i32 3, ; 134
	i32 42, ; 135
	i32 63, ; 136
	i32 16, ; 137
	i32 53, ; 138
	i32 214, ; 139
	i32 333, ; 140
	i32 297, ; 141
	i32 212, ; 142
	i32 105, ; 143
	i32 197, ; 144
	i32 302, ; 145
	i32 293, ; 146
	i32 255, ; 147
	i32 34, ; 148
	i32 158, ; 149
	i32 85, ; 150
	i32 32, ; 151
	i32 12, ; 152
	i32 51, ; 153
	i32 56, ; 154
	i32 276, ; 155
	i32 36, ; 156
	i32 218, ; 157
	i32 181, ; 158
	i32 308, ; 159
	i32 294, ; 160
	i32 228, ; 161
	i32 35, ; 162
	i32 58, ; 163
	i32 262, ; 164
	i32 177, ; 165
	i32 17, ; 166
	i32 299, ; 167
	i32 164, ; 168
	i32 321, ; 169
	i32 261, ; 170
	i32 184, ; 171
	i32 289, ; 172
	i32 215, ; 173
	i32 327, ; 174
	i32 153, ; 175
	i32 285, ; 176
	i32 270, ; 177
	i32 325, ; 178
	i32 230, ; 179
	i32 29, ; 180
	i32 176, ; 181
	i32 52, ; 182
	i32 323, ; 183
	i32 290, ; 184
	i32 5, ; 185
	i32 307, ; 186
	i32 295, ; 187
	i32 280, ; 188
	i32 284, ; 189
	i32 235, ; 190
	i32 303, ; 191
	i32 227, ; 192
	i32 198, ; 193
	i32 246, ; 194
	i32 85, ; 195
	i32 210, ; 196
	i32 289, ; 197
	i32 61, ; 198
	i32 112, ; 199
	i32 193, ; 200
	i32 57, ; 201
	i32 337, ; 202
	i32 276, ; 203
	i32 99, ; 204
	i32 267, ; 205
	i32 19, ; 206
	i32 239, ; 207
	i32 296, ; 208
	i32 111, ; 209
	i32 101, ; 210
	i32 102, ; 211
	i32 305, ; 212
	i32 104, ; 213
	i32 293, ; 214
	i32 71, ; 215
	i32 38, ; 216
	i32 32, ; 217
	i32 103, ; 218
	i32 73, ; 219
	i32 311, ; 220
	i32 9, ; 221
	i32 123, ; 222
	i32 46, ; 223
	i32 229, ; 224
	i32 186, ; 225
	i32 9, ; 226
	i32 210, ; 227
	i32 43, ; 228
	i32 4, ; 229
	i32 277, ; 230
	i32 315, ; 231
	i32 310, ; 232
	i32 31, ; 233
	i32 138, ; 234
	i32 92, ; 235
	i32 93, ; 236
	i32 330, ; 237
	i32 49, ; 238
	i32 141, ; 239
	i32 112, ; 240
	i32 140, ; 241
	i32 245, ; 242
	i32 115, ; 243
	i32 294, ; 244
	i32 157, ; 245
	i32 76, ; 246
	i32 79, ; 247
	i32 265, ; 248
	i32 37, ; 249
	i32 288, ; 250
	i32 174, ; 251
	i32 249, ; 252
	i32 242, ; 253
	i32 175, ; 254
	i32 64, ; 255
	i32 138, ; 256
	i32 15, ; 257
	i32 116, ; 258
	i32 282, ; 259
	i32 291, ; 260
	i32 237, ; 261
	i32 48, ; 262
	i32 70, ; 263
	i32 80, ; 264
	i32 126, ; 265
	i32 94, ; 266
	i32 121, ; 267
	i32 300, ; 268
	i32 217, ; 269
	i32 26, ; 270
	i32 199, ; 271
	i32 0, ; 272
	i32 258, ; 273
	i32 97, ; 274
	i32 28, ; 275
	i32 233, ; 276
	i32 328, ; 277
	i32 306, ; 278
	i32 149, ; 279
	i32 169, ; 280
	i32 4, ; 281
	i32 98, ; 282
	i32 33, ; 283
	i32 207, ; 284
	i32 93, ; 285
	i32 281, ; 286
	i32 182, ; 287
	i32 21, ; 288
	i32 41, ; 289
	i32 170, ; 290
	i32 322, ; 291
	i32 251, ; 292
	i32 314, ; 293
	i32 265, ; 294
	i32 299, ; 295
	i32 291, ; 296
	i32 271, ; 297
	i32 2, ; 298
	i32 134, ; 299
	i32 111, ; 300
	i32 183, ; 301
	i32 334, ; 302
	i32 220, ; 303
	i32 331, ; 304
	i32 58, ; 305
	i32 95, ; 306
	i32 313, ; 307
	i32 39, ; 308
	i32 231, ; 309
	i32 25, ; 310
	i32 94, ; 311
	i32 89, ; 312
	i32 99, ; 313
	i32 10, ; 314
	i32 206, ; 315
	i32 87, ; 316
	i32 100, ; 317
	i32 278, ; 318
	i32 178, ; 319
	i32 300, ; 320
	i32 214, ; 321
	i32 222, ; 322
	i32 310, ; 323
	i32 7, ; 324
	i32 262, ; 325
	i32 305, ; 326
	i32 219, ; 327
	i32 88, ; 328
	i32 257, ; 329
	i32 154, ; 330
	i32 309, ; 331
	i32 33, ; 332
	i32 116, ; 333
	i32 200, ; 334
	i32 82, ; 335
	i32 201, ; 336
	i32 211, ; 337
	i32 218, ; 338
	i32 20, ; 339
	i32 11, ; 340
	i32 162, ; 341
	i32 3, ; 342
	i32 190, ; 343
	i32 317, ; 344
	i32 185, ; 345
	i32 183, ; 346
	i32 84, ; 347
	i32 304, ; 348
	i32 64, ; 349
	i32 204, ; 350
	i32 319, ; 351
	i32 285, ; 352
	i32 143, ; 353
	i32 216, ; 354
	i32 0, ; 355
	i32 266, ; 356
	i32 157, ; 357
	i32 41, ; 358
	i32 117, ; 359
	i32 179, ; 360
	i32 221, ; 361
	i32 313, ; 362
	i32 274, ; 363
	i32 131, ; 364
	i32 75, ; 365
	i32 66, ; 366
	i32 323, ; 367
	i32 172, ; 368
	i32 225, ; 369
	i32 143, ; 370
	i32 106, ; 371
	i32 151, ; 372
	i32 70, ; 373
	i32 202, ; 374
	i32 156, ; 375
	i32 178, ; 376
	i32 121, ; 377
	i32 127, ; 378
	i32 318, ; 379
	i32 152, ; 380
	i32 248, ; 381
	i32 141, ; 382
	i32 235, ; 383
	i32 315, ; 384
	i32 20, ; 385
	i32 14, ; 386
	i32 175, ; 387
	i32 135, ; 388
	i32 75, ; 389
	i32 59, ; 390
	i32 196, ; 391
	i32 238, ; 392
	i32 167, ; 393
	i32 168, ; 394
	i32 204, ; 395
	i32 188, ; 396
	i32 15, ; 397
	i32 74, ; 398
	i32 6, ; 399
	i32 23, ; 400
	i32 260, ; 401
	i32 205, ; 402
	i32 219, ; 403
	i32 91, ; 404
	i32 316, ; 405
	i32 1, ; 406
	i32 136, ; 407
	i32 261, ; 408
	i32 284, ; 409
	i32 134, ; 410
	i32 69, ; 411
	i32 146, ; 412
	i32 325, ; 413
	i32 304, ; 414
	i32 252, ; 415
	i32 184, ; 416
	i32 88, ; 417
	i32 96, ; 418
	i32 242, ; 419
	i32 247, ; 420
	i32 215, ; 421
	i32 320, ; 422
	i32 31, ; 423
	i32 45, ; 424
	i32 256, ; 425
	i32 221, ; 426
	i32 109, ; 427
	i32 158, ; 428
	i32 35, ; 429
	i32 22, ; 430
	i32 114, ; 431
	i32 57, ; 432
	i32 282, ; 433
	i32 213, ; 434
	i32 144, ; 435
	i32 118, ; 436
	i32 120, ; 437
	i32 110, ; 438
	i32 223, ; 439
	i32 139, ; 440
	i32 229, ; 441
	i32 54, ; 442
	i32 105, ; 443
	i32 326, ; 444
	i32 197, ; 445
	i32 189, ; 446
	i32 190, ; 447
	i32 133, ; 448
	i32 298, ; 449
	i32 287, ; 450
	i32 275, ; 451
	i32 332, ; 452
	i32 252, ; 453
	i32 212, ; 454
	i32 192, ; 455
	i32 159, ; 456
	i32 311, ; 457
	i32 239, ; 458
	i32 163, ; 459
	i32 132, ; 460
	i32 275, ; 461
	i32 161, ; 462
	i32 324, ; 463
	i32 263, ; 464
	i32 140, ; 465
	i32 287, ; 466
	i32 283, ; 467
	i32 169, ; 468
	i32 191, ; 469
	i32 174, ; 470
	i32 202, ; 471
	i32 224, ; 472
	i32 292, ; 473
	i32 40, ; 474
	i32 250, ; 475
	i32 81, ; 476
	i32 56, ; 477
	i32 37, ; 478
	i32 97, ; 479
	i32 166, ; 480
	i32 172, ; 481
	i32 288, ; 482
	i32 82, ; 483
	i32 226, ; 484
	i32 98, ; 485
	i32 30, ; 486
	i32 159, ; 487
	i32 18, ; 488
	i32 295, ; 489
	i32 127, ; 490
	i32 119, ; 491
	i32 246, ; 492
	i32 278, ; 493
	i32 259, ; 494
	i32 280, ; 495
	i32 165, ; 496
	i32 254, ; 497
	i32 205, ; 498
	i32 339, ; 499
	i32 277, ; 500
	i32 268, ; 501
	i32 170, ; 502
	i32 16, ; 503
	i32 144, ; 504
	i32 317, ; 505
	i32 125, ; 506
	i32 118, ; 507
	i32 38, ; 508
	i32 115, ; 509
	i32 47, ; 510
	i32 142, ; 511
	i32 117, ; 512
	i32 213, ; 513
	i32 34, ; 514
	i32 203, ; 515
	i32 177, ; 516
	i32 95, ; 517
	i32 53, ; 518
	i32 269, ; 519
	i32 211, ; 520
	i32 129, ; 521
	i32 153, ; 522
	i32 24, ; 523
	i32 161, ; 524
	i32 245, ; 525
	i32 148, ; 526
	i32 104, ; 527
	i32 89, ; 528
	i32 194, ; 529
	i32 233, ; 530
	i32 60, ; 531
	i32 142, ; 532
	i32 100, ; 533
	i32 5, ; 534
	i32 13, ; 535
	i32 195, ; 536
	i32 122, ; 537
	i32 135, ; 538
	i32 28, ; 539
	i32 312, ; 540
	i32 72, ; 541
	i32 243, ; 542
	i32 24, ; 543
	i32 209, ; 544
	i32 231, ; 545
	i32 273, ; 546
	i32 270, ; 547
	i32 329, ; 548
	i32 137, ; 549
	i32 198, ; 550
	i32 224, ; 551
	i32 240, ; 552
	i32 168, ; 553
	i32 274, ; 554
	i32 308, ; 555
	i32 101, ; 556
	i32 217, ; 557
	i32 123, ; 558
	i32 244, ; 559
	i32 180, ; 560
	i32 163, ; 561
	i32 167, ; 562
	i32 247, ; 563
	i32 39, ; 564
	i32 187, ; 565
	i32 316, ; 566
	i32 17, ; 567
	i32 171, ; 568
	i32 329, ; 569
	i32 328, ; 570
	i32 137, ; 571
	i32 150, ; 572
	i32 236, ; 573
	i32 155, ; 574
	i32 130, ; 575
	i32 19, ; 576
	i32 65, ; 577
	i32 147, ; 578
	i32 47, ; 579
	i32 336, ; 580
	i32 222, ; 581
	i32 79, ; 582
	i32 61, ; 583
	i32 106, ; 584
	i32 272, ; 585
	i32 226, ; 586
	i32 49, ; 587
	i32 257, ; 588
	i32 333, ; 589
	i32 269, ; 590
	i32 14, ; 591
	i32 179, ; 592
	i32 68, ; 593
	i32 193, ; 594
	i32 171, ; 595
	i32 232, ; 596
	i32 236, ; 597
	i32 338, ; 598
	i32 78, ; 599
	i32 241, ; 600
	i32 108, ; 601
	i32 225, ; 602
	i32 268, ; 603
	i32 67, ; 604
	i32 63, ; 605
	i32 27, ; 606
	i32 160, ; 607
	i32 201, ; 608
	i32 234, ; 609
	i32 10, ; 610
	i32 187, ; 611
	i32 11, ; 612
	i32 173, ; 613
	i32 78, ; 614
	i32 267, ; 615
	i32 126, ; 616
	i32 83, ; 617
	i32 181, ; 618
	i32 66, ; 619
	i32 107, ; 620
	i32 65, ; 621
	i32 128, ; 622
	i32 122, ; 623
	i32 195, ; 624
	i32 77, ; 625
	i32 283, ; 626
	i32 273, ; 627
	i32 337, ; 628
	i32 8, ; 629
	i32 240, ; 630
	i32 2, ; 631
	i32 44, ; 632
	i32 286, ; 633
	i32 156, ; 634
	i32 128, ; 635
	i32 271, ; 636
	i32 23, ; 637
	i32 133, ; 638
	i32 228, ; 639
	i32 259, ; 640
	i32 332, ; 641
	i32 314, ; 642
	i32 29, ; 643
	i32 227, ; 644
	i32 62, ; 645
	i32 189, ; 646
	i32 90, ; 647
	i32 87, ; 648
	i32 148, ; 649
	i32 191, ; 650
	i32 36, ; 651
	i32 86, ; 652
	i32 248, ; 653
	i32 327, ; 654
	i32 322, ; 655
	i32 180, ; 656
	i32 50, ; 657
	i32 6, ; 658
	i32 90, ; 659
	i32 334, ; 660
	i32 21, ; 661
	i32 162, ; 662
	i32 96, ; 663
	i32 50, ; 664
	i32 216, ; 665
	i32 113, ; 666
	i32 264, ; 667
	i32 130, ; 668
	i32 207, ; 669
	i32 76, ; 670
	i32 27, ; 671
	i32 241, ; 672
	i32 263, ; 673
	i32 7, ; 674
	i32 188, ; 675
	i32 176, ; 676
	i32 110, ; 677
	i32 264, ; 678
	i32 250 ; 679
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
