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

@assembly_image_cache = dso_local local_unnamed_addr global [165 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [330 x i32] [
	i32 35999526, ; 0: Xamarin.Firebase.Functions.dll => 0x2254f26 => 108
	i32 38948123, ; 1: ar\Microsoft.Maui.Controls.resources.dll => 0x2524d1b => 0
	i32 42244203, ; 2: he\Microsoft.Maui.Controls.resources.dll => 0x284986b => 9
	i32 42639949, ; 3: System.Threading.Thread => 0x28aa24d => 156
	i32 67008169, ; 4: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 72070932, ; 5: Microsoft.Maui.Graphics.dll => 0x44bb714 => 62
	i32 83839681, ; 6: ms\Microsoft.Maui.Controls.resources.dll => 0x4ff4ac1 => 17
	i32 117431740, ; 7: System.Runtime.InteropServices => 0x6ffddbc => 148
	i32 136584136, ; 8: zh-Hans\Microsoft.Maui.Controls.resources.dll => 0x8241bc8 => 32
	i32 140062828, ; 9: sk\Microsoft.Maui.Controls.resources.dll => 0x859306c => 25
	i32 147669188, ; 10: Plugin.Firebase.Core.dll => 0x8cd40c4 => 67
	i32 159306688, ; 11: System.ComponentModel.Annotations => 0x97ed3c0 => 127
	i32 182336117, ; 12: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 96
	i32 205061960, ; 13: System.ComponentModel => 0xc38ff48 => 130
	i32 218153831, ; 14: KTKGuest.WebComponents => 0xd00c367 => 121
	i32 254259026, ; 15: Microsoft.AspNetCore.Components.dll => 0xf27af52 => 39
	i32 317674968, ; 16: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 17: Xamarin.AndroidX.Activity.dll => 0x13031348 => 74
	i32 321963286, ; 18: fr\Microsoft.Maui.Controls.resources.dll => 0x1330c516 => 8
	i32 327734428, ; 19: Plugin.Firebase.Storage.dll => 0x1388d49c => 73
	i32 342366114, ; 20: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 85
	i32 379916513, ; 21: System.Threading.Thread.dll => 0x16a510e1 => 156
	i32 385762202, ; 22: System.Memory.dll => 0x16fe439a => 138
	i32 395744057, ; 23: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 409257351, ; 24: tr\Microsoft.Maui.Controls.resources.dll => 0x1864c587 => 28
	i32 419109368, ; 25: Plugin.Firebase.Firestore.dll => 0x18fb19f8 => 70
	i32 442565967, ; 26: System.Collections => 0x1a61054f => 126
	i32 450948140, ; 27: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 84
	i32 459347974, ; 28: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 150
	i32 469710990, ; 29: System.dll => 0x1bff388e => 160
	i32 489220957, ; 30: es\Microsoft.Maui.Controls.resources.dll => 0x1d28eb5d => 6
	i32 498788369, ; 31: System.ObjectModel => 0x1dbae811 => 144
	i32 507148113, ; 32: Xamarin.Google.Android.DataTransport.TransportApi.dll => 0x1e3a7751 => 111
	i32 513247710, ; 33: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 56
	i32 538707440, ; 34: th\Microsoft.Maui.Controls.resources.dll => 0x201c05f0 => 27
	i32 539058512, ; 35: Microsoft.Extensions.Logging => 0x20216150 => 53
	i32 571435654, ; 36: Microsoft.Extensions.FileProviders.Embedded.dll => 0x220f6a86 => 50
	i32 627609679, ; 37: Xamarin.AndroidX.CustomView => 0x2568904f => 82
	i32 627931235, ; 38: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 645564943, ; 39: KTKGuest.Shared => 0x267a8a0f => 120
	i32 662205335, ; 40: System.Text.Encodings.Web.dll => 0x27787397 => 153
	i32 663517072, ; 41: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 97
	i32 672442732, ; 42: System.Collections.Concurrent => 0x2814a96c => 123
	i32 690569205, ; 43: System.Xml.Linq.dll => 0x29293ff5 => 158
	i32 722857257, ; 44: System.Runtime.Loader.dll => 0x2b15ed29 => 149
	i32 759454413, ; 45: System.Net.Requests => 0x2d445acd => 142
	i32 775507847, ; 46: System.IO.Compression => 0x2e394f87 => 134
	i32 777317022, ; 47: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 48: Microsoft.Extensions.Options => 0x2f0980eb => 55
	i32 804008546, ; 49: Microsoft.AspNetCore.Components.WebView.Maui => 0x2fec3262 => 43
	i32 823281589, ; 50: System.Private.Uri.dll => 0x311247b5 => 145
	i32 830298997, ; 51: System.IO.Compression.Brotli => 0x317d5b75 => 133
	i32 856800933, ; 52: Plugin.Firebase.CloudMessaging.dll => 0x3311bea5 => 66
	i32 869139383, ; 53: hi\Microsoft.Maui.Controls.resources.dll => 0x33ce03b7 => 10
	i32 878954865, ; 54: System.Net.Http.Json => 0x3463c971 => 139
	i32 880668424, ; 55: ru\Microsoft.Maui.Controls.resources.dll => 0x347def08 => 24
	i32 904024072, ; 56: System.ComponentModel.Primitives.dll => 0x35e25008 => 128
	i32 918734561, ; 57: pt-BR\Microsoft.Maui.Controls.resources.dll => 0x36c2c6e1 => 21
	i32 961460050, ; 58: it\Microsoft.Maui.Controls.resources.dll => 0x394eb752 => 14
	i32 965247473, ; 59: Plugin.Firebase.Core => 0x398881f1 => 67
	i32 967690846, ; 60: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 85
	i32 990727110, ; 61: ro\Microsoft.Maui.Controls.resources.dll => 0x3b0d4bc6 => 23
	i32 992768348, ; 62: System.Collections.dll => 0x3b2c715c => 126
	i32 999186168, ; 63: Microsoft.Extensions.FileSystemGlobbing.dll => 0x3b8e5ef8 => 52
	i32 1001378077, ; 64: Plugin.Firebase.Firestore => 0x3bafd11d => 70
	i32 1012816738, ; 65: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 95
	i32 1028951442, ; 66: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 47
	i32 1035644815, ; 67: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 75
	i32 1036772482, ; 68: Plugin.Firebase.Functions => 0x3dcbe482 => 71
	i32 1043950537, ; 69: de\Microsoft.Maui.Controls.resources.dll => 0x3e396bc9 => 4
	i32 1044663988, ; 70: System.Linq.Expressions.dll => 0x3e444eb4 => 136
	i32 1052210849, ; 71: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 87
	i32 1067306892, ; 72: GoogleGson => 0x3f9dcf8c => 38
	i32 1082857460, ; 73: System.ComponentModel.TypeConverter => 0x408b17f4 => 129
	i32 1084122840, ; 74: Xamarin.Kotlin.StdLib => 0x409e66d8 => 117
	i32 1098259244, ; 75: System => 0x41761b2c => 160
	i32 1104211310, ; 76: KTKGuest.Shared.dll => 0x41d0ed6e => 120
	i32 1108272742, ; 77: sv\Microsoft.Maui.Controls.resources.dll => 0x420ee666 => 26
	i32 1110581358, ; 78: Xamarin.Firebase.Auth => 0x4232206e => 100
	i32 1117529484, ; 79: pl\Microsoft.Maui.Controls.resources.dll => 0x429c258c => 20
	i32 1118262833, ; 80: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 81: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1173126369, ; 82: Microsoft.Extensions.FileProviders.Abstractions.dll => 0x45ec7ce1 => 48
	i32 1178241025, ; 83: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 92
	i32 1246548578, ; 84: Xamarin.AndroidX.Collection.Jvm.dll => 0x4a4cd262 => 78
	i32 1260983243, ; 85: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1271773322, ; 86: Plugin.Firebase.RemoteConfig.dll => 0x4bcdb88a => 72
	i32 1293217323, ; 87: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 83
	i32 1308624726, ; 88: hr\Microsoft.Maui.Controls.resources.dll => 0x4e000756 => 11
	i32 1324164729, ; 89: System.Linq => 0x4eed2679 => 137
	i32 1333047053, ; 90: Xamarin.Firebase.Common => 0x4f74af0d => 102
	i32 1336711579, ; 91: zh-HK\Microsoft.Maui.Controls.resources.dll => 0x4fac999b => 31
	i32 1373134921, ; 92: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 93: Xamarin.AndroidX.SavedState => 0x52114ed3 => 95
	i32 1406073936, ; 94: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 79
	i32 1411702249, ; 95: Xamarin.Firebase.Auth.Interop.dll => 0x5424dde9 => 101
	i32 1430672901, ; 96: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1454105418, ; 97: Microsoft.Extensions.FileProviders.Composite => 0x56abe34a => 49
	i32 1461004990, ; 98: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 99: System.IO.Compression.dll => 0x57261233 => 134
	i32 1469204771, ; 100: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 76
	i32 1470490898, ; 101: Microsoft.Extensions.Primitives => 0x57a5e912 => 56
	i32 1480492111, ; 102: System.IO.Compression.Brotli.dll => 0x583e844f => 133
	i32 1518347465, ; 103: Xamarin.Firebase.Config.dll => 0x5a8024c9 => 104
	i32 1521091094, ; 104: Microsoft.Extensions.FileSystemGlobbing => 0x5aaa0216 => 52
	i32 1526286932, ; 105: vi\Microsoft.Maui.Controls.resources.dll => 0x5af94a54 => 30
	i32 1543031311, ; 106: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 155
	i32 1546581739, ; 107: Microsoft.AspNetCore.Components.WebView.Maui.dll => 0x5c2ef6eb => 43
	i32 1616467958, ; 108: Blazored.Toast => 0x605957f6 => 37
	i32 1622152042, ; 109: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 89
	i32 1624863272, ; 110: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 99
	i32 1636350590, ; 111: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 81
	i32 1639515021, ; 112: System.Net.Http.dll => 0x61b9038d => 140
	i32 1639986890, ; 113: System.Text.RegularExpressions => 0x61c036ca => 155
	i32 1654881142, ; 114: Microsoft.AspNetCore.Components.WebView => 0x62a37b76 => 42
	i32 1657153582, ; 115: System.Runtime => 0x62c6282e => 151
	i32 1658251792, ; 116: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 112
	i32 1677501392, ; 117: System.Net.Primitives.dll => 0x63fca3d0 => 141
	i32 1679018464, ; 118: Blazored.LocalStorage => 0x6413c9e0 => 35
	i32 1679769178, ; 119: System.Security.Cryptography => 0x641f3e5a => 152
	i32 1701606402, ; 120: Plugin.Firebase.DynamicLinks => 0x656c7402 => 69
	i32 1718376423, ; 121: Blazored.SessionStorage => 0x666c57e7 => 36
	i32 1729485958, ; 122: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 77
	i32 1743415430, ; 123: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1760259689, ; 124: Microsoft.AspNetCore.Components.Web.dll => 0x68eb6e69 => 41
	i32 1766324549, ; 125: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 96
	i32 1770582343, ; 126: Microsoft.Extensions.Logging.dll => 0x6988f147 => 53
	i32 1780572499, ; 127: Mono.Android.Runtime.dll => 0x6a216153 => 163
	i32 1782862114, ; 128: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 129: Xamarin.AndroidX.Fragment => 0x6a96652d => 84
	i32 1793755602, ; 130: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 131: Xamarin.AndroidX.Loader => 0x6bcd3296 => 89
	i32 1813058853, ; 132: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 117
	i32 1813201214, ; 133: Xamarin.Google.Android.Material => 0x6c13413e => 112
	i32 1818569960, ; 134: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 93
	i32 1828688058, ; 135: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 54
	i32 1853025655, ; 136: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 137: System.Linq.Expressions => 0x6ec71a65 => 136
	i32 1875053220, ; 138: Xamarin.Firebase.Auth.Interop => 0x6fc30aa4 => 101
	i32 1875478451, ; 139: KTKGuest.Client => 0x6fc987b3 => 122
	i32 1875935024, ; 140: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1893218855, ; 141: cs\Microsoft.Maui.Controls.resources.dll => 0x70d83a27 => 2
	i32 1908813208, ; 142: Xamarin.GooglePlayServices.Basement => 0x71c62d98 => 114
	i32 1910275211, ; 143: System.Collections.NonGeneric.dll => 0x71dc7c8b => 124
	i32 1933215285, ; 144: Xamarin.Firebase.Messaging.dll => 0x733a8635 => 109
	i32 1939592360, ; 145: System.Private.Xml.Linq => 0x739bd4a8 => 146
	i32 1943407207, ; 146: Plugin.Firebase.Auth => 0x73d60a67 => 65
	i32 1949618224, ; 147: Plugin.Firebase.DynamicLinks.dll => 0x7434d030 => 69
	i32 1953182387, ; 148: id\Microsoft.Maui.Controls.resources.dll => 0x746b32b3 => 13
	i32 1968388702, ; 149: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 44
	i32 2003115576, ; 150: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 151: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 87
	i32 2045470958, ; 152: System.Private.Xml => 0x79eb68ee => 147
	i32 2055257422, ; 153: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 86
	i32 2066184531, ; 154: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2072397586, ; 155: Microsoft.Extensions.FileProviders.Physical => 0x7b864712 => 51
	i32 2079903147, ; 156: System.Runtime.dll => 0x7bf8cdab => 151
	i32 2090596640, ; 157: System.Numerics.Vectors => 0x7c9bf920 => 143
	i32 2099092933, ; 158: Plugin.Firebase.dll => 0x7d1d9dc5 => 63
	i32 2127167465, ; 159: System.Console => 0x7ec9ffe9 => 131
	i32 2129483829, ; 160: Xamarin.GooglePlayServices.Base.dll => 0x7eed5835 => 113
	i32 2142473426, ; 161: System.Collections.Specialized => 0x7fb38cd2 => 125
	i32 2159891885, ; 162: Microsoft.Maui => 0x80bd55ad => 60
	i32 2169148018, ; 163: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 164: Microsoft.Extensions.Options.dll => 0x820d22b3 => 55
	i32 2191887180, ; 165: Xamarin.GooglePlayServices.Measurement.Api.dll => 0x82a58b4c => 115
	i32 2192057212, ; 166: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 54
	i32 2193016926, ; 167: System.ObjectModel.dll => 0x82b6c85e => 144
	i32 2201107256, ; 168: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 118
	i32 2201231467, ; 169: System.Net.Http => 0x8334206b => 140
	i32 2207618523, ; 170: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2212189310, ; 171: Plugin.Firebase.Storage => 0x83db547e => 73
	i32 2243920916, ; 172: Xamarin.Firebase.Functions => 0x85bf8414 => 108
	i32 2266799131, ; 173: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 45
	i32 2279755925, ; 174: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 94
	i32 2303942373, ; 175: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305348475, ; 176: Xamarin.Firebase.Storage.dll => 0x8968d37b => 110
	i32 2305521784, ; 177: System.Private.CoreLib.dll => 0x896b7878 => 161
	i32 2311968808, ; 178: Blazored.LocalStorage.dll => 0x89cdd828 => 35
	i32 2353062107, ; 179: System.Net.Primitives => 0x8c40e0db => 141
	i32 2366048013, ; 180: hu\Microsoft.Maui.Controls.resources.dll => 0x8d07070d => 12
	i32 2368005991, ; 181: System.Xml.ReaderWriter.dll => 0x8d24e767 => 159
	i32 2371007202, ; 182: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 44
	i32 2382033717, ; 183: Xamarin.Firebase.Auth.dll => 0x8dfaf335 => 100
	i32 2395872292, ; 184: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2411328690, ; 185: Microsoft.AspNetCore.Components => 0x8fb9f4b2 => 39
	i32 2427813419, ; 186: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 187: System.Console.dll => 0x912896e5 => 131
	i32 2442556106, ; 188: Microsoft.JSInterop.dll => 0x919672ca => 57
	i32 2449790861, ; 189: Xamarin.Firebase.Crashlytics.dll => 0x9204d78d => 105
	i32 2475788418, ; 190: Java.Interop.dll => 0x93918882 => 162
	i32 2480646305, ; 191: Microsoft.Maui.Controls => 0x93dba8a1 => 58
	i32 2483742551, ; 192: Xamarin.Firebase.Messaging => 0x940ae757 => 109
	i32 2503351294, ; 193: ko\Microsoft.Maui.Controls.resources.dll => 0x95361bfe => 16
	i32 2534138912, ; 194: Xamarin.Firebase.Crashlytics => 0x970be420 => 105
	i32 2550873716, ; 195: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2570120770, ; 196: System.Text.Encodings.Web => 0x9930ee42 => 153
	i32 2572217609, ; 197: KTKGuest.WebComponents.dll => 0x9950ed09 => 121
	i32 2576534780, ; 198: ja\Microsoft.Maui.Controls.resources.dll => 0x9992ccfc => 15
	i32 2585813321, ; 199: Microsoft.AspNetCore.Components.Forms => 0x9a206149 => 40
	i32 2592341985, ; 200: Microsoft.Extensions.FileProviders.Abstractions => 0x9a83ffe1 => 48
	i32 2593496499, ; 201: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 202: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 118
	i32 2617129537, ; 203: System.Private.Xml.dll => 0x9bfe3a41 => 147
	i32 2620871830, ; 204: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 81
	i32 2621637141, ; 205: Plugin.Firebase.Auth.dll => 0x9c430215 => 65
	i32 2626831493, ; 206: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2646186088, ; 207: Blazored.Toast.dll => 0x9db99868 => 37
	i32 2663698177, ; 208: System.Runtime.Loader => 0x9ec4cf01 => 149
	i32 2692077919, ; 209: Microsoft.AspNetCore.Components.WebView.dll => 0xa075d95f => 42
	i32 2732626843, ; 210: Xamarin.AndroidX.Activity => 0xa2e0939b => 74
	i32 2737747696, ; 211: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 76
	i32 2740698338, ; 212: ca\Microsoft.Maui.Controls.resources.dll => 0xa35bbce2 => 1
	i32 2752363754, ; 213: Xamarin.Firebase.Firestore.dll => 0xa40dbcea => 107
	i32 2752995522, ; 214: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 215: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 59
	i32 2760209227, ; 216: Plugin.Firebase => 0xa485734b => 63
	i32 2762169073, ; 217: Plugin.Firebase.Analytics.dll => 0xa4a35af1 => 64
	i32 2764765095, ; 218: Microsoft.Maui.dll => 0xa4caf7a7 => 60
	i32 2767811655, ; 219: Xamarin.Firebase.Dynamic.Links => 0xa4f97447 => 106
	i32 2778768386, ; 220: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 98
	i32 2785988530, ; 221: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2799649579, ; 222: Xamarin.Protobuf.JavaLite.dll => 0xa6df432b => 119
	i32 2801831435, ; 223: Microsoft.Maui.Graphics => 0xa7008e0b => 62
	i32 2804607052, ; 224: Xamarin.Firebase.Components.dll => 0xa72ae84c => 103
	i32 2810250172, ; 225: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 79
	i32 2847418871, ; 226: Xamarin.GooglePlayServices.Base => 0xa9b829f7 => 113
	i32 2849915857, ; 227: Blazored.SessionStorage.dll => 0xa9de43d1 => 36
	i32 2853208004, ; 228: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 98
	i32 2861189240, ; 229: Microsoft.Maui.Essentials => 0xaa8a4878 => 61
	i32 2892341533, ; 230: Microsoft.AspNetCore.Components.Web => 0xac65a11d => 41
	i32 2909740682, ; 231: System.Private.CoreLib => 0xad6f1e8a => 161
	i32 2911054922, ; 232: Microsoft.Extensions.FileProviders.Physical.dll => 0xad832c4a => 51
	i32 2916838712, ; 233: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 99
	i32 2919462931, ; 234: System.Numerics.Vectors.dll => 0xae037813 => 143
	i32 2959614098, ; 235: System.ComponentModel.dll => 0xb0682092 => 130
	i32 2978675010, ; 236: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 83
	i32 3005585190, ; 237: Plugin.Firebase.RemoteConfig => 0xb3259726 => 72
	i32 3038032645, ; 238: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3053864966, ; 239: fi\Microsoft.Maui.Controls.resources.dll => 0xb6064806 => 7
	i32 3057625584, ; 240: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 90
	i32 3058099980, ; 241: Xamarin.GooglePlayServices.Tasks => 0xb646e70c => 116
	i32 3059408633, ; 242: Mono.Android.Runtime => 0xb65adef9 => 163
	i32 3059793426, ; 243: System.ComponentModel.Primitives => 0xb660be12 => 128
	i32 3071899978, ; 244: Xamarin.Firebase.Common.dll => 0xb719794a => 102
	i32 3097728972, ; 245: Xamarin.Firebase.Config => 0xb8a397cc => 104
	i32 3148237826, ; 246: GoogleGson.dll => 0xbba64c02 => 38
	i32 3155362983, ; 247: Xamarin.Google.Android.DataTransport.TransportApi => 0xbc1304a7 => 111
	i32 3178803400, ; 248: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 91
	i32 3220365878, ; 249: System.Threading => 0xbff2e236 => 157
	i32 3222740722, ; 250: Xamarin.Protobuf.JavaLite => 0xc0171ef2 => 119
	i32 3230466174, ; 251: Xamarin.GooglePlayServices.Basement.dll => 0xc08d007e => 114
	i32 3258312781, ; 252: Xamarin.AndroidX.CardView => 0xc235e84d => 77
	i32 3280506390, ; 253: System.ComponentModel.Annotations.dll => 0xc3888e16 => 127
	i32 3290505561, ; 254: Plugin.Firebase.Functions.dll => 0xc4212159 => 71
	i32 3305363605, ; 255: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 256: System.Net.Requests.dll => 0xc5b097e4 => 142
	i32 3317135071, ; 257: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 82
	i32 3346324047, ; 258: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 92
	i32 3357674450, ; 259: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 260: System.Text.Json => 0xc82afec1 => 154
	i32 3362522851, ; 261: Xamarin.AndroidX.Core => 0xc86c06e3 => 80
	i32 3366347497, ; 262: Java.Interop => 0xc8a662e9 => 162
	i32 3374999561, ; 263: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 94
	i32 3381016424, ; 264: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3406629867, ; 265: Microsoft.Extensions.FileProviders.Composite.dll => 0xcb0d0beb => 49
	i32 3428513518, ; 266: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 46
	i32 3437748879, ; 267: Xamarin.Firebase.Storage => 0xcce7e28f => 110
	i32 3458724246, ; 268: pt\Microsoft.Maui.Controls.resources.dll => 0xce27f196 => 22
	i32 3464190856, ; 269: Microsoft.AspNetCore.Components.Forms.dll => 0xce7b5b88 => 40
	i32 3471940407, ; 270: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 129
	i32 3476120550, ; 271: Mono.Android => 0xcf3163e6 => 164
	i32 3484440000, ; 272: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 273: System.Text.Json.dll => 0xcfbaacae => 154
	i32 3500000672, ; 274: Microsoft.JSInterop => 0xd09dc5a0 => 57
	i32 3509114376, ; 275: System.Xml.Linq => 0xd128d608 => 158
	i32 3580758918, ; 276: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3592228221, ; 277: zh-Hant\Microsoft.Maui.Controls.resources.dll => 0xd61d0d7d => 33
	i32 3597794883, ; 278: Xamarin.Firebase.Firestore => 0xd671fe43 => 107
	i32 3608519521, ; 279: System.Linq.dll => 0xd715a361 => 137
	i32 3641597786, ; 280: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 86
	i32 3643446276, ; 281: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 282: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 91
	i32 3657292374, ; 283: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 45
	i32 3666791084, ; 284: Plugin.Firebase.Crashlytics.dll => 0xda8ecaac => 68
	i32 3672681054, ; 285: Mono.Android.dll => 0xdae8aa5e => 164
	i32 3724971120, ; 286: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 90
	i32 3735869466, ; 287: Plugin.Firebase.Analytics => 0xdeacd81a => 64
	i32 3737834244, ; 288: System.Net.Http.Json.dll => 0xdecad304 => 139
	i32 3748608112, ; 289: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 132
	i32 3751619990, ; 290: da\Microsoft.Maui.Controls.resources.dll => 0xdf9d2d96 => 3
	i32 3792276235, ; 291: System.Collections.NonGeneric => 0xe2098b0b => 124
	i32 3802395368, ; 292: System.Collections.Specialized.dll => 0xe2a3f2e8 => 125
	i32 3823082795, ; 293: System.Security.Cryptography.dll => 0xe3df9d2b => 152
	i32 3833491424, ; 294: KTKGuest.Client.dll => 0xe47e6fe0 => 122
	i32 3841636137, ; 295: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 47
	i32 3849253459, ; 296: System.Runtime.InteropServices.dll => 0xe56ef253 => 148
	i32 3896106733, ; 297: System.Collections.Concurrent.dll => 0xe839deed => 123
	i32 3896760992, ; 298: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 80
	i32 3910130544, ; 299: Xamarin.AndroidX.Collection.Jvm => 0xe90fdb70 => 78
	i32 3920221145, ; 300: nl\Microsoft.Maui.Controls.resources.dll => 0xe9a9d3d9 => 19
	i32 3921031405, ; 301: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 97
	i32 3928044579, ; 302: System.Xml.ReaderWriter => 0xea213423 => 159
	i32 3931092270, ; 303: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 93
	i32 3955647286, ; 304: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 75
	i32 3970018735, ; 305: Xamarin.GooglePlayServices.Tasks.dll => 0xeca1adaf => 116
	i32 3979528423, ; 306: Plugin.Firebase.CloudMessaging => 0xed32c8e7 => 66
	i32 4005556595, ; 307: Plugin.Firebase.Crashlytics => 0xeebff173 => 68
	i32 4025784931, ; 308: System.Memory => 0xeff49a63 => 138
	i32 4046471985, ; 309: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 59
	i32 4068434129, ; 310: System.Private.Xml.Linq.dll => 0xf27f60d1 => 146
	i32 4073602200, ; 311: System.Threading.dll => 0xf2ce3c98 => 157
	i32 4091086043, ; 312: el\Microsoft.Maui.Controls.resources.dll => 0xf3d904db => 5
	i32 4094352644, ; 313: Microsoft.Maui.Essentials.dll => 0xf40add04 => 61
	i32 4100113165, ; 314: System.Private.Uri => 0xf462c30d => 145
	i32 4103439459, ; 315: uk\Microsoft.Maui.Controls.resources.dll => 0xf4958463 => 29
	i32 4126470640, ; 316: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 46
	i32 4127667938, ; 317: System.IO.FileSystem.Watcher => 0xf60736e2 => 135
	i32 4150914736, ; 318: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4164802419, ; 319: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 135
	i32 4181436372, ; 320: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 150
	i32 4182413190, ; 321: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 88
	i32 4213026141, ; 322: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 132
	i32 4238158203, ; 323: Xamarin.GooglePlayServices.Measurement.Api => 0xfc9d297b => 115
	i32 4242216077, ; 324: Xamarin.Firebase.Dynamic.Links.dll => 0xfcdb148d => 106
	i32 4249188766, ; 325: nb\Microsoft.Maui.Controls.resources.dll => 0xfd45799e => 18
	i32 4271975918, ; 326: Microsoft.Maui.Controls.dll => 0xfea12dee => 58
	i32 4284549794, ; 327: Xamarin.Firebase.Components => 0xff610aa2 => 103
	i32 4292120959, ; 328: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 88
	i32 4294648842 ; 329: Microsoft.Extensions.FileProviders.Embedded => 0xfffb240a => 50
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [330 x i32] [
	i32 108, ; 0
	i32 0, ; 1
	i32 9, ; 2
	i32 156, ; 3
	i32 33, ; 4
	i32 62, ; 5
	i32 17, ; 6
	i32 148, ; 7
	i32 32, ; 8
	i32 25, ; 9
	i32 67, ; 10
	i32 127, ; 11
	i32 96, ; 12
	i32 130, ; 13
	i32 121, ; 14
	i32 39, ; 15
	i32 30, ; 16
	i32 74, ; 17
	i32 8, ; 18
	i32 73, ; 19
	i32 85, ; 20
	i32 156, ; 21
	i32 138, ; 22
	i32 34, ; 23
	i32 28, ; 24
	i32 70, ; 25
	i32 126, ; 26
	i32 84, ; 27
	i32 150, ; 28
	i32 160, ; 29
	i32 6, ; 30
	i32 144, ; 31
	i32 111, ; 32
	i32 56, ; 33
	i32 27, ; 34
	i32 53, ; 35
	i32 50, ; 36
	i32 82, ; 37
	i32 19, ; 38
	i32 120, ; 39
	i32 153, ; 40
	i32 97, ; 41
	i32 123, ; 42
	i32 158, ; 43
	i32 149, ; 44
	i32 142, ; 45
	i32 134, ; 46
	i32 25, ; 47
	i32 55, ; 48
	i32 43, ; 49
	i32 145, ; 50
	i32 133, ; 51
	i32 66, ; 52
	i32 10, ; 53
	i32 139, ; 54
	i32 24, ; 55
	i32 128, ; 56
	i32 21, ; 57
	i32 14, ; 58
	i32 67, ; 59
	i32 85, ; 60
	i32 23, ; 61
	i32 126, ; 62
	i32 52, ; 63
	i32 70, ; 64
	i32 95, ; 65
	i32 47, ; 66
	i32 75, ; 67
	i32 71, ; 68
	i32 4, ; 69
	i32 136, ; 70
	i32 87, ; 71
	i32 38, ; 72
	i32 129, ; 73
	i32 117, ; 74
	i32 160, ; 75
	i32 120, ; 76
	i32 26, ; 77
	i32 100, ; 78
	i32 20, ; 79
	i32 16, ; 80
	i32 22, ; 81
	i32 48, ; 82
	i32 92, ; 83
	i32 78, ; 84
	i32 2, ; 85
	i32 72, ; 86
	i32 83, ; 87
	i32 11, ; 88
	i32 137, ; 89
	i32 102, ; 90
	i32 31, ; 91
	i32 32, ; 92
	i32 95, ; 93
	i32 79, ; 94
	i32 101, ; 95
	i32 0, ; 96
	i32 49, ; 97
	i32 6, ; 98
	i32 134, ; 99
	i32 76, ; 100
	i32 56, ; 101
	i32 133, ; 102
	i32 104, ; 103
	i32 52, ; 104
	i32 30, ; 105
	i32 155, ; 106
	i32 43, ; 107
	i32 37, ; 108
	i32 89, ; 109
	i32 99, ; 110
	i32 81, ; 111
	i32 140, ; 112
	i32 155, ; 113
	i32 42, ; 114
	i32 151, ; 115
	i32 112, ; 116
	i32 141, ; 117
	i32 35, ; 118
	i32 152, ; 119
	i32 69, ; 120
	i32 36, ; 121
	i32 77, ; 122
	i32 1, ; 123
	i32 41, ; 124
	i32 96, ; 125
	i32 53, ; 126
	i32 163, ; 127
	i32 17, ; 128
	i32 84, ; 129
	i32 9, ; 130
	i32 89, ; 131
	i32 117, ; 132
	i32 112, ; 133
	i32 93, ; 134
	i32 54, ; 135
	i32 26, ; 136
	i32 136, ; 137
	i32 101, ; 138
	i32 122, ; 139
	i32 8, ; 140
	i32 2, ; 141
	i32 114, ; 142
	i32 124, ; 143
	i32 109, ; 144
	i32 146, ; 145
	i32 65, ; 146
	i32 69, ; 147
	i32 13, ; 148
	i32 44, ; 149
	i32 5, ; 150
	i32 87, ; 151
	i32 147, ; 152
	i32 86, ; 153
	i32 4, ; 154
	i32 51, ; 155
	i32 151, ; 156
	i32 143, ; 157
	i32 63, ; 158
	i32 131, ; 159
	i32 113, ; 160
	i32 125, ; 161
	i32 60, ; 162
	i32 12, ; 163
	i32 55, ; 164
	i32 115, ; 165
	i32 54, ; 166
	i32 144, ; 167
	i32 118, ; 168
	i32 140, ; 169
	i32 14, ; 170
	i32 73, ; 171
	i32 108, ; 172
	i32 45, ; 173
	i32 94, ; 174
	i32 18, ; 175
	i32 110, ; 176
	i32 161, ; 177
	i32 35, ; 178
	i32 141, ; 179
	i32 12, ; 180
	i32 159, ; 181
	i32 44, ; 182
	i32 100, ; 183
	i32 13, ; 184
	i32 39, ; 185
	i32 10, ; 186
	i32 131, ; 187
	i32 57, ; 188
	i32 105, ; 189
	i32 162, ; 190
	i32 58, ; 191
	i32 109, ; 192
	i32 16, ; 193
	i32 105, ; 194
	i32 11, ; 195
	i32 153, ; 196
	i32 121, ; 197
	i32 15, ; 198
	i32 40, ; 199
	i32 48, ; 200
	i32 20, ; 201
	i32 118, ; 202
	i32 147, ; 203
	i32 81, ; 204
	i32 65, ; 205
	i32 15, ; 206
	i32 37, ; 207
	i32 149, ; 208
	i32 42, ; 209
	i32 74, ; 210
	i32 76, ; 211
	i32 1, ; 212
	i32 107, ; 213
	i32 21, ; 214
	i32 59, ; 215
	i32 63, ; 216
	i32 64, ; 217
	i32 60, ; 218
	i32 106, ; 219
	i32 98, ; 220
	i32 27, ; 221
	i32 119, ; 222
	i32 62, ; 223
	i32 103, ; 224
	i32 79, ; 225
	i32 113, ; 226
	i32 36, ; 227
	i32 98, ; 228
	i32 61, ; 229
	i32 41, ; 230
	i32 161, ; 231
	i32 51, ; 232
	i32 99, ; 233
	i32 143, ; 234
	i32 130, ; 235
	i32 83, ; 236
	i32 72, ; 237
	i32 34, ; 238
	i32 7, ; 239
	i32 90, ; 240
	i32 116, ; 241
	i32 163, ; 242
	i32 128, ; 243
	i32 102, ; 244
	i32 104, ; 245
	i32 38, ; 246
	i32 111, ; 247
	i32 91, ; 248
	i32 157, ; 249
	i32 119, ; 250
	i32 114, ; 251
	i32 77, ; 252
	i32 127, ; 253
	i32 71, ; 254
	i32 7, ; 255
	i32 142, ; 256
	i32 82, ; 257
	i32 92, ; 258
	i32 24, ; 259
	i32 154, ; 260
	i32 80, ; 261
	i32 162, ; 262
	i32 94, ; 263
	i32 3, ; 264
	i32 49, ; 265
	i32 46, ; 266
	i32 110, ; 267
	i32 22, ; 268
	i32 40, ; 269
	i32 129, ; 270
	i32 164, ; 271
	i32 23, ; 272
	i32 154, ; 273
	i32 57, ; 274
	i32 158, ; 275
	i32 31, ; 276
	i32 33, ; 277
	i32 107, ; 278
	i32 137, ; 279
	i32 86, ; 280
	i32 28, ; 281
	i32 91, ; 282
	i32 45, ; 283
	i32 68, ; 284
	i32 164, ; 285
	i32 90, ; 286
	i32 64, ; 287
	i32 139, ; 288
	i32 132, ; 289
	i32 3, ; 290
	i32 124, ; 291
	i32 125, ; 292
	i32 152, ; 293
	i32 122, ; 294
	i32 47, ; 295
	i32 148, ; 296
	i32 123, ; 297
	i32 80, ; 298
	i32 78, ; 299
	i32 19, ; 300
	i32 97, ; 301
	i32 159, ; 302
	i32 93, ; 303
	i32 75, ; 304
	i32 116, ; 305
	i32 66, ; 306
	i32 68, ; 307
	i32 138, ; 308
	i32 59, ; 309
	i32 146, ; 310
	i32 157, ; 311
	i32 5, ; 312
	i32 61, ; 313
	i32 145, ; 314
	i32 29, ; 315
	i32 46, ; 316
	i32 135, ; 317
	i32 29, ; 318
	i32 135, ; 319
	i32 150, ; 320
	i32 88, ; 321
	i32 132, ; 322
	i32 115, ; 323
	i32 106, ; 324
	i32 18, ; 325
	i32 58, ; 326
	i32 103, ; 327
	i32 88, ; 328
	i32 50 ; 329
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
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.1xx @ af27162bee43b7fecdca59b4f67aa8c175cbc875"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
