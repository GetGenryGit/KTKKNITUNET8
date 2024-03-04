; ModuleID = 'marshal_methods.arm64-v8a.ll'
source_filename = "marshal_methods.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [165 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [330 x i64] [
	i64 17578172352203612, ; 0: Plugin.Firebase.Storage => 0x3e73412eda8b5c => 73
	i64 98382396393917666, ; 1: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 56
	i64 120698629574877762, ; 2: Mono.Android => 0x1accec39cafe242 => 164
	i64 131669012237370309, ; 3: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 61
	i64 196720943101637631, ; 4: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 136
	i64 232391251801502327, ; 5: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 95
	i64 233177144301842968, ; 6: Xamarin.AndroidX.Collection.Jvm.dll => 0x33c696097d9f218 => 78
	i64 454362216236841667, ; 7: Plugin.Firebase.Analytics => 0x64e38074227fac3 => 64
	i64 496033116923926409, ; 8: KTKGuest.Shared.dll => 0x6e2437de3149789 => 120
	i64 683390398661839228, ; 9: Microsoft.Extensions.FileProviders.Embedded => 0x97be3f26326c97c => 50
	i64 687654259221141486, ; 10: Xamarin.GooglePlayServices.Base => 0x98b09e7c92917ee => 113
	i64 750875890346172408, ; 11: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 156
	i64 799765834175365804, ; 12: System.ComponentModel.dll => 0xb1956c9f18442ac => 130
	i64 805302231655005164, ; 13: hu\Microsoft.Maui.Controls.resources.dll => 0xb2d021ceea03bec => 12
	i64 872800313462103108, ; 14: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 83
	i64 934108404909400019, ; 15: Blazored.Toast.dll => 0xcf69ea52854dfd3 => 37
	i64 1120440138749646132, ; 16: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 112
	i64 1213069524004690018, ; 17: Plugin.Firebase.DynamicLinks => 0x10d5b04e1226d862 => 69
	i64 1369545283391376210, ; 18: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 91
	i64 1392315331768750440, ; 19: Xamarin.Firebase.Auth.Interop.dll => 0x13527f6add681168 => 101
	i64 1404195534211153682, ; 20: System.IO.FileSystem.Watcher.dll => 0x137cb4660bd87f12 => 135
	i64 1465843056802068477, ; 21: Xamarin.Firebase.Components.dll => 0x1457b87e6928f7fd => 103
	i64 1476839205573959279, ; 22: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 141
	i64 1486715745332614827, ; 23: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 58
	i64 1513467482682125403, ; 24: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 163
	i64 1537168428375924959, ; 25: System.Threading.Thread.dll => 0x15551e8a954ae0df => 156
	i64 1624659445732251991, ; 26: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 76
	i64 1628611045998245443, ; 27: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 88
	i64 1743969030606105336, ; 28: System.Memory.dll => 0x1833d297e88f2af8 => 138
	i64 1767386781656293639, ; 29: System.Private.Uri.dll => 0x188704e9f5582107 => 145
	i64 1776954265264967804, ; 30: Microsoft.JSInterop.dll => 0x18a9027d533bd07c => 57
	i64 1795316252682057001, ; 31: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 75
	i64 1835311033149317475, ; 32: es\Microsoft.Maui.Controls.resources => 0x197855a927386163 => 6
	i64 1836611346387731153, ; 33: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 95
	i64 1881198190668717030, ; 34: tr\Microsoft.Maui.Controls.resources => 0x1a1b5bc992ea9be6 => 28
	i64 1888734231285419719, ; 35: Blazored.LocalStorage => 0x1a3621c6c2e34ec7 => 35
	i64 1920760634179481754, ; 36: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 59
	i64 1981742497975770890, ; 37: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 87
	i64 2052224852812364517, ; 38: Plugin.Firebase.Firestore.dll => 0x1c7af7a1671bfae5 => 70
	i64 2262844636196693701, ; 39: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 83
	i64 2287834202362508563, ; 40: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 123
	i64 2295368378960711535, ; 41: Microsoft.AspNetCore.Components.WebView.Maui.dll => 0x1fdac961189e0f6f => 43
	i64 2329709569556905518, ; 42: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 86
	i64 2335503487726329082, ; 43: System.Text.Encodings.Web => 0x2069600c4d9d1cfa => 153
	i64 2470498323731680442, ; 44: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 79
	i64 2497223385847772520, ; 45: System.Runtime => 0x22a7eb7046413568 => 151
	i64 2547086958574651984, ; 46: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 74
	i64 2602673633151553063, ; 47: th\Microsoft.Maui.Controls.resources => 0x241e8de13a460e27 => 27
	i64 2656907746661064104, ; 48: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 46
	i64 2662981627730767622, ; 49: cs\Microsoft.Maui.Controls.resources => 0x24f4cfae6c48af06 => 2
	i64 2781169761569919449, ; 50: Microsoft.JSInterop => 0x2698b329b26ed1d9 => 57
	i64 2895129759130297543, ; 51: fi\Microsoft.Maui.Controls.resources => 0x282d912d479fa4c7 => 7
	i64 3017704767998173186, ; 52: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 112
	i64 3289520064315143713, ; 53: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 85
	i64 3311221304742556517, ; 54: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 143
	i64 3344514922410554693, ; 55: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 118
	i64 3364695309916733813, ; 56: Xamarin.Firebase.Common => 0x2eb1cc8eb5028175 => 102
	i64 3396143930648122816, ; 57: Microsoft.Extensions.FileProviders.Abstractions => 0x2f2186e9506155c0 => 48
	i64 3411255996856937470, ; 58: Xamarin.GooglePlayServices.Basement => 0x2f5737416a942bfe => 114
	i64 3429672777697402584, ; 59: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 61
	i64 3494946837667399002, ; 60: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 44
	i64 3495566828071521632, ; 61: Xamarin.GooglePlayServices.Measurement.Api.dll => 0x3082bf8283d78d60 => 115
	i64 3522470458906976663, ; 62: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 96
	i64 3551103847008531295, ; 63: System.Private.CoreLib.dll => 0x31480e226177735f => 161
	i64 3567343442040498961, ; 64: pt\Microsoft.Maui.Controls.resources => 0x3181bff5bea4ab11 => 22
	i64 3571415421602489686, ; 65: System.Runtime.dll => 0x319037675df7e556 => 151
	i64 3638003163729360188, ; 66: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 45
	i64 3647754201059316852, ; 67: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 159
	i64 3655542548057982301, ; 68: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 44
	i64 3727469159507183293, ; 69: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 94
	i64 3753897248517198740, ; 70: Microsoft.AspNetCore.Components.WebView.dll => 0x341885a8952f1394 => 42
	i64 3869221888984012293, ; 71: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 53
	i64 3889433610606858880, ; 72: Microsoft.Extensions.FileProviders.Physical.dll => 0x35fa0b4301afd280 => 51
	i64 3890352374528606784, ; 73: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 59
	i64 3933965368022646939, ; 74: System.Net.Requests => 0x369840a8bfadc09b => 142
	i64 3966267475168208030, ; 75: System.Memory => 0x370b03412596249e => 138
	i64 4009997192427317104, ; 76: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 150
	i64 4070326265757318011, ; 77: da\Microsoft.Maui.Controls.resources.dll => 0x387cb42c56683b7b => 3
	i64 4073500526318903918, ; 78: System.Private.Xml.dll => 0x3887fb25779ae26e => 147
	i64 4085039559542030877, ; 79: Plugin.Firebase.RemoteConfig => 0x38b0f9d5ffebc21d => 72
	i64 4120493066591692148, ; 80: zh-Hant\Microsoft.Maui.Controls.resources => 0x392eee9cdda86574 => 33
	i64 4154383907710350974, ; 81: System.ComponentModel => 0x39a7562737acb67e => 130
	i64 4156011472231154272, ; 82: Plugin.Firebase.Crashlytics => 0x39ad1e6a1cc94260 => 68
	i64 4187479170553454871, ; 83: System.Linq.Expressions => 0x3a1cea1e912fa117 => 136
	i64 4205801962323029395, ; 84: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 129
	i64 4247996603072512073, ; 85: Xamarin.GooglePlayServices.Tasks => 0x3af3ea6755340049 => 116
	i64 4344734875814815696, ; 86: Plugin.Firebase.Analytics.dll => 0x3c4b9959a43167d0 => 64
	i64 4360412976914417659, ; 87: tr\Microsoft.Maui.Controls.resources.dll => 0x3c834c8002fcc7fb => 28
	i64 4384840217421645357, ; 88: Microsoft.AspNetCore.Components.Forms => 0x3cda14f22443862d => 40
	i64 4636684751163556186, ; 89: Xamarin.AndroidX.VersionedParcelable.dll => 0x4058d0370893015a => 97
	i64 4672453897036726049, ; 90: System.IO.FileSystem.Watcher => 0x40d7e4104a437f21 => 135
	i64 4702770163853758138, ; 91: Xamarin.Firebase.Components => 0x4143988c34cf0eba => 103
	i64 4743821336939966868, ; 92: System.ComponentModel.Annotations => 0x41d5705f4239b194 => 127
	i64 4794310189461587505, ; 93: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 74
	i64 4795410492532947900, ; 94: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 96
	i64 4853321196694829351, ; 95: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 149
	i64 4853355175641069576, ; 96: Plugin.Firebase.RemoteConfig.dll => 0x435a94d16ce3b808 => 72
	i64 4871824391508510238, ; 97: nb\Microsoft.Maui.Controls.resources.dll => 0x439c3278d7f2c61e => 18
	i64 4953714692329509532, ; 98: sv\Microsoft.Maui.Controls.resources.dll => 0x44bf21444aef129c => 26
	i64 5103417709280584325, ; 99: System.Collections.Specialized => 0x46d2fb5e161b6285 => 125
	i64 5121125348355654245, ; 100: KTKGuest.Client => 0x4711e45f16fcc265 => 122
	i64 5182934613077526976, ; 101: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 125
	i64 5197073077358930460, ; 102: Microsoft.AspNetCore.Components.Web.dll => 0x481fb66db7b9aa1c => 41
	i64 5290786973231294105, ; 103: System.Runtime.Loader => 0x496ca6b869b72699 => 149
	i64 5426193594926737925, ; 104: Plugin.Firebase.Core => 0x4b4db6534c1baa05 => 67
	i64 5471532531798518949, ; 105: sv\Microsoft.Maui.Controls.resources => 0x4beec9d926d82ca5 => 26
	i64 5522859530602327440, ; 106: uk\Microsoft.Maui.Controls.resources => 0x4ca5237b51eead90 => 29
	i64 5570799893513421663, ; 107: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 133
	i64 5573260873512690141, ; 108: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 152
	i64 5692067934154308417, ; 109: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 99
	i64 6076057840849113382, ; 110: Xamarin.Firebase.Dynamic.Links.dll => 0x54527e69f689d126 => 106
	i64 6200764641006662125, ; 111: ro\Microsoft.Maui.Controls.resources => 0x560d8a96830131ed => 23
	i64 6222399776351216807, ; 112: System.Text.Json.dll => 0x565a67a0ffe264a7 => 154
	i64 6300676701234028427, ; 113: es\Microsoft.Maui.Controls.resources.dll => 0x57708013cda25f8b => 6
	i64 6357457916754632952, ; 114: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 34
	i64 6401242110442382339, ; 115: Xamarin.Protobuf.JavaLite => 0x58d5c7c8c230a403 => 119
	i64 6401687960814735282, ; 116: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 86
	i64 6403742896930319886, ; 117: Xamarin.Firebase.Auth.dll => 0x58deaa3c7c766e0e => 100
	i64 6444987688569083917, ; 118: Plugin.Firebase.Storage.dll => 0x59713227deed180d => 73
	i64 6471714727257221498, ; 119: fi\Microsoft.Maui.Controls.resources.dll => 0x59d026417dd4a97a => 7
	i64 6478287442656530074, ; 120: hr\Microsoft.Maui.Controls.resources => 0x59e7801b0c6a8e9a => 11
	i64 6522864429860654155, ; 121: Plugin.Firebase => 0x5a85dea3abe00c4b => 63
	i64 6548213210057960872, ; 122: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 82
	i64 6560151584539558821, ; 123: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 55
	i64 6594803674001204912, ; 124: Plugin.Firebase.CloudMessaging => 0x5b857300304866b0 => 66
	i64 6690776524695692178, ; 125: Xamarin.Firebase.Crashlytics.dll => 0x5cda69ccca026392 => 105
	i64 6743165466166707109, ; 126: nl\Microsoft.Maui.Controls.resources => 0x5d948943c08c43a5 => 19
	i64 6876862101832370452, ; 127: System.Xml.Linq => 0x5f6f85a57d108914 => 158
	i64 6894844156784520562, ; 128: System.Numerics.Vectors => 0x5faf683aead1ad72 => 143
	i64 6920570528939222495, ; 129: Microsoft.AspNetCore.Components.WebView => 0x600ace3ab475a5df => 42
	i64 7083547580668757502, ; 130: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 146
	i64 7158676156446871556, ; 131: Xamarin.Firebase.Functions.dll => 0x6358ba0937131004 => 108
	i64 7270811800166795866, ; 132: System.Linq => 0x64e71ccf51a90a5a => 137
	i64 7377312882064240630, ; 133: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 129
	i64 7446349959216394011, ; 134: Plugin.Firebase.DynamicLinks.dll => 0x6756bfd5e0566f1b => 69
	i64 7488575175965059935, ; 135: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 158
	i64 7489048572193775167, ; 136: System.ObjectModel => 0x67ee71ff6b419e3f => 144
	i64 7586519340370716875, ; 137: Plugin.Firebase.Auth => 0x6948bb251c6d68cb => 65
	i64 7654504624184590948, ; 138: System.Net.Http => 0x6a3a4366801b8264 => 140
	i64 7714652370974252055, ; 139: System.Private.CoreLib => 0x6b0ff375198b9c17 => 161
	i64 7735352534559001595, ; 140: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 117
	i64 7742555799473854801, ; 141: it\Microsoft.Maui.Controls.resources.dll => 0x6b73157a51479951 => 14
	i64 7836164640616011524, ; 142: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 76
	i64 7974216756248484795, ; 143: Plugin.Firebase.Functions.dll => 0x6eaa1be3fe289bbb => 71
	i64 7975724199463739455, ; 144: sk\Microsoft.Maui.Controls.resources.dll => 0x6eaf76e6f785e03f => 25
	i64 7991572870742010042, ; 145: Xamarin.Firebase.Firestore.dll => 0x6ee7c52f4d39e8ba => 107
	i64 8014722069583580780, ; 146: Microsoft.AspNetCore.Components.Forms.dll => 0x6f3a03422b034e6c => 40
	i64 8064050204834738623, ; 147: System.Collections.dll => 0x6fe942efa61731bf => 126
	i64 8083354569033831015, ; 148: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 85
	i64 8085230611270010360, ; 149: System.Net.Http.Json.dll => 0x703482674fdd05f8 => 139
	i64 8087206902342787202, ; 150: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 132
	i64 8108129031893776750, ; 151: ko\Microsoft.Maui.Controls.resources.dll => 0x7085dc65530f796e => 16
	i64 8167236081217502503, ; 152: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 162
	i64 8185542183669246576, ; 153: System.Collections => 0x7198e33f4794aa70 => 126
	i64 8246048515196606205, ; 154: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 62
	i64 8368701292315763008, ; 155: System.Security.Cryptography => 0x7423997c6fd56140 => 152
	i64 8386351099740279196, ; 156: zh-HK\Microsoft.Maui.Controls.resources.dll => 0x74624de475b9d19c => 31
	i64 8400357532724379117, ; 157: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 93
	i64 8465511506719290632, ; 158: Xamarin.Firebase.Messaging.dll => 0x757b89dcf7fc3508 => 109
	i64 8563666267364444763, ; 159: System.Private.Uri => 0x76d841191140ca5b => 145
	i64 8626175481042262068, ; 160: Java.Interop => 0x77b654e585b55834 => 162
	i64 8639588376636138208, ; 161: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 92
	i64 8677882282824630478, ; 162: pt-BR\Microsoft.Maui.Controls.resources => 0x786e07f5766b00ce => 21
	i64 8725526185868997716, ; 163: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 132
	i64 8828892993892926228, ; 164: Xamarin.Firebase.Config.dll => 0x7a86876684ec4314 => 104
	i64 8834404175818295388, ; 165: Xamarin.Firebase.Dynamic.Links => 0x7a9a1bca8de0885c => 106
	i64 9017840326336271361, ; 166: Xamarin.Firebase.Functions => 0x7d25cdff8c775401 => 108
	i64 9045785047181495996, ; 167: zh-HK\Microsoft.Maui.Controls.resources => 0x7d891592e3cb0ebc => 31
	i64 9113579748781016974, ; 168: Xamarin.Firebase.Storage.dll => 0x7e79f07ee649478e => 110
	i64 9285318971778582014, ; 169: Plugin.Firebase.Core.dll => 0x80dc1468bb0ec5fe => 67
	i64 9312692141327339315, ; 170: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 99
	i64 9324707631942237306, ; 171: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 75
	i64 9363564275759486853, ; 172: el\Microsoft.Maui.Controls.resources.dll => 0x81f21019382e9785 => 5
	i64 9551379474083066910, ; 173: uk\Microsoft.Maui.Controls.resources.dll => 0x848d5106bbadb41e => 29
	i64 9659729154652888475, ; 174: System.Text.RegularExpressions => 0x860e407c9991dd9b => 155
	i64 9678050649315576968, ; 175: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 79
	i64 9702891218465930390, ; 176: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 124
	i64 9773637193738963987, ; 177: ca\Microsoft.Maui.Controls.resources.dll => 0x87a2ef3ea85b4c13 => 1
	i64 9808709177481450983, ; 178: Mono.Android.dll => 0x881f890734e555e7 => 164
	i64 9875200773399460291, ; 179: Xamarin.GooglePlayServices.Base.dll => 0x890bc2c8482339c3 => 113
	i64 9956195530459977388, ; 180: Microsoft.Maui => 0x8a2b8315b36616ac => 60
	i64 10038780035334861115, ; 181: System.Net.Http.dll => 0x8b50e941206af13b => 140
	i64 10051358222726253779, ; 182: System.Private.Xml => 0x8b7d990c97ccccd3 => 147
	i64 10092835686693276772, ; 183: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 58
	i64 10143853363526200146, ; 184: da\Microsoft.Maui.Controls.resources => 0x8cc634e3c2a16b52 => 3
	i64 10209869394718195525, ; 185: nl\Microsoft.Maui.Controls.resources.dll => 0x8db0be1ecb4f7f45 => 19
	i64 10229024438826829339, ; 186: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 82
	i64 10406448008575299332, ; 187: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 118
	i64 10414489992181150686, ; 188: KTKGuest.Shared => 0x9087b37834d173de => 120
	i64 10430153318873392755, ; 189: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 80
	i64 10506226065143327199, ; 190: ca\Microsoft.Maui.Controls.resources => 0x91cd9cf11ed169df => 1
	i64 10734191584620811116, ; 191: Microsoft.Extensions.FileProviders.Embedded.dll => 0x94f7825fc04f936c => 50
	i64 10761706286639228993, ; 192: zh-Hant\Microsoft.Maui.Controls.resources.dll => 0x955942d988382841 => 33
	i64 10785150219063592792, ; 193: System.Net.Primitives => 0x95ac8cfb68830758 => 141
	i64 10842631359359123634, ; 194: Plugin.Firebase.Auth.dll => 0x9678c3c64d1c80b2 => 65
	i64 11002576679268595294, ; 195: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 54
	i64 11009005086950030778, ; 196: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 60
	i64 11051904132540108364, ; 197: Microsoft.Extensions.FileProviders.Composite.dll => 0x99604040c7b98e4c => 49
	i64 11103970607964515343, ; 198: hu\Microsoft.Maui.Controls.resources => 0x9a193a6fc41a6c0f => 12
	i64 11156122287428000958, ; 199: th\Microsoft.Maui.Controls.resources.dll => 0x9ad2821cdcf6dcbe => 27
	i64 11157797727133427779, ; 200: fr\Microsoft.Maui.Controls.resources.dll => 0x9ad875ea9172e843 => 8
	i64 11162124722117608902, ; 201: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 98
	i64 11218356222449480316, ; 202: Microsoft.AspNetCore.Components => 0x9baf9b8c02e4f27c => 39
	i64 11220793807500858938, ; 203: ja\Microsoft.Maui.Controls.resources => 0x9bb8448481fdd63a => 15
	i64 11226290749488709958, ; 204: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 55
	i64 11299661109949763898, ; 205: Xamarin.AndroidX.Collection.Jvm => 0x9cd075e94cda113a => 78
	i64 11340910727871153756, ; 206: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 81
	i64 11447157834785892323, ; 207: Blazored.SessionStorage => 0x9edc7966ae3e27e3 => 36
	i64 11485890710487134646, ; 208: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 148
	i64 11518296021396496455, ; 209: id\Microsoft.Maui.Controls.resources => 0x9fd9353475222047 => 13
	i64 11529969570048099689, ; 210: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 98
	i64 11530571088791430846, ; 211: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 53
	i64 11532627626288463329, ; 212: KTKGuest.WebComponents => 0xa00c1fb93fc7bde1 => 121
	i64 11543422055205009205, ; 213: Xamarin.Firebase.Firestore => 0xa032793314e77735 => 107
	i64 11707295265961861272, ; 214: Plugin.Firebase.Crashlytics.dll => 0xa278ab043844e098 => 68
	i64 11845716948639519119, ; 215: Xamarin.Firebase.Config => 0xa46470cdb17b918f => 104
	i64 11855031688536399763, ; 216: vi\Microsoft.Maui.Controls.resources.dll => 0xa485888294361f93 => 30
	i64 11864794479965678424, ; 217: Xamarin.Protobuf.JavaLite.dll => 0xa4a837b7975eab58 => 119
	i64 12001571089067798639, ; 218: Blazored.SessionStorage.dll => 0xa68e2551867bf06f => 36
	i64 12010362171126083089, ; 219: Plugin.Firebase.CloudMessaging.dll => 0xa6ad60c2d1c26e11 => 66
	i64 12048689113179125827, ; 220: Microsoft.Extensions.FileProviders.Physical => 0xa7358ae968287843 => 51
	i64 12058074296353848905, ; 221: Microsoft.Extensions.FileSystemGlobbing.dll => 0xa756e2afa5707e49 => 52
	i64 12130675990699684169, ; 222: Plugin.Firebase.Functions => 0xa858d18adf03b149 => 71
	i64 12145679461940342714, ; 223: System.Text.Json => 0xa88e1f1ebcb62fba => 154
	i64 12199822034229429413, ; 224: Plugin.Firebase.Firestore => 0xa94e7980b13a84a5 => 70
	i64 12201331334810686224, ; 225: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 150
	i64 12451044538927396471, ; 226: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 84
	i64 12466513435562512481, ; 227: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 89
	i64 12475113361194491050, ; 228: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 34
	i64 12538491095302438457, ; 229: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 77
	i64 12550732019250633519, ; 230: System.IO.Compression => 0xae2d28465e8e1b2f => 134
	i64 12843321153144804894, ; 231: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 56
	i64 12989346753972519995, ; 232: ar\Microsoft.Maui.Controls.resources.dll => 0xb4436e0d5ee7c43b => 0
	i64 13003699287675270979, ; 233: Microsoft.AspNetCore.Components.WebView.Maui => 0xb4766b9b07e27743 => 43
	i64 13005833372463390146, ; 234: pt-BR\Microsoft.Maui.Controls.resources.dll => 0xb47e008b5d99ddc2 => 21
	i64 13090691281631479721, ; 235: KTKGuest.Client.dll => 0xb5ab7a5cf9f287a9 => 122
	i64 13288890004631981845, ; 236: KTKGuest.WebComponents.dll => 0xb86b9f0d39540f15 => 121
	i64 13343850469010654401, ; 237: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 163
	i64 13381594904270902445, ; 238: he\Microsoft.Maui.Controls.resources => 0xb9b4f9aaad3e94ad => 9
	i64 13465488254036897740, ; 239: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 117
	i64 13540124433173649601, ; 240: vi\Microsoft.Maui.Controls.resources => 0xbbe82f6eede718c1 => 30
	i64 13550417756503177631, ; 241: Microsoft.Extensions.FileProviders.Abstractions.dll => 0xbc0cc1280684799f => 48
	i64 13572454107664307259, ; 242: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 94
	i64 13597693765308912490, ; 243: Blazored.LocalStorage.dll => 0xbcb4b66f95c8136a => 35
	i64 13717397318615465333, ; 244: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 128
	i64 13761131323945450492, ; 245: Xamarin.Firebase.Storage => 0xbef95c078f44fbfc => 110
	i64 13881769479078963060, ; 246: System.Console.dll => 0xc0a5f3cade5c6774 => 131
	i64 13959074834287824816, ; 247: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 84
	i64 14124974489674258913, ; 248: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 77
	i64 14125464355221830302, ; 249: System.Threading.dll => 0xc407bafdbc707a9e => 157
	i64 14165531176311179688, ; 250: Xamarin.Firebase.Auth => 0xc496138d7abfc9a8 => 100
	i64 14349907877893689639, ; 251: ro\Microsoft.Maui.Controls.resources.dll => 0xc7251d2f956ed127 => 23
	i64 14382082037123372364, ; 252: Xamarin.Firebase.Auth.Interop => 0xc7976b69c943d54c => 101
	i64 14461014870687870182, ; 253: System.Net.Requests.dll => 0xc8afd8683afdece6 => 142
	i64 14464374589798375073, ; 254: ru\Microsoft.Maui.Controls.resources => 0xc8bbc80dcb1e5ea1 => 24
	i64 14491877563792607819, ; 255: zh-Hans\Microsoft.Maui.Controls.resources.dll => 0xc91d7ddcee4fca4b => 32
	i64 14551742072151931844, ; 256: System.Text.Encodings.Web.dll => 0xc9f22c50f1b8fbc4 => 153
	i64 14610046442689856844, ; 257: cs\Microsoft.Maui.Controls.resources.dll => 0xcac14fd5107d054c => 2
	i64 14669215534098758659, ; 258: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 46
	i64 14705122255218365489, ; 259: ko\Microsoft.Maui.Controls.resources => 0xcc1316c7b0fb5431 => 16
	i64 14735017007120366644, ; 260: ja\Microsoft.Maui.Controls.resources.dll => 0xcc7d4be604bfbc34 => 15
	i64 14744092281598614090, ; 261: zh-Hans\Microsoft.Maui.Controls.resources => 0xcc9d89d004439a4a => 32
	i64 14786806131582421479, ; 262: Plugin.Firebase.dll => 0xcd3549d53389c9e7 => 63
	i64 14789919016435397935, ; 263: Xamarin.Firebase.Common.dll => 0xcd4058fc2f6d352f => 102
	i64 14852515768018889994, ; 264: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 81
	i64 14889905118082851278, ; 265: GoogleGson.dll => 0xcea391d0969961ce => 38
	i64 14904040806490515477, ; 266: ar\Microsoft.Maui.Controls.resources => 0xced5ca2604cb2815 => 0
	i64 14954917835170835695, ; 267: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 47
	i64 14987728460634540364, ; 268: System.IO.Compression.dll => 0xcfff1ba06622494c => 134
	i64 15024878362326791334, ; 269: System.Net.Http.Json => 0xd0831743ebf0f4a6 => 139
	i64 15076659072870671916, ; 270: System.ObjectModel.dll => 0xd13b0d8c1620662c => 144
	i64 15111608613780139878, ; 271: ms\Microsoft.Maui.Controls.resources => 0xd1b737f831192f66 => 17
	i64 15115185479366240210, ; 272: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 133
	i64 15133485256822086103, ; 273: System.Linq.dll => 0xd204f0a9127dd9d7 => 137
	i64 15203009853192377507, ; 274: pt\Microsoft.Maui.Controls.resources.dll => 0xd2fbf0e9984b94a3 => 22
	i64 15227001540531775957, ; 275: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 45
	i64 15370334346939861994, ; 276: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 80
	i64 15391712275433856905, ; 277: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 47
	i64 15427448221306938193, ; 278: Microsoft.AspNetCore.Components.Web => 0xd6194e6b4dbb6351 => 41
	i64 15481710163200268842, ; 279: Microsoft.Extensions.FileProviders.Composite => 0xd6da155e291b5a2a => 49
	i64 15527772828719725935, ; 280: System.Console => 0xd77dbb1e38cd3d6f => 131
	i64 15536481058354060254, ; 281: de\Microsoft.Maui.Controls.resources => 0xd79cab34eec75bde => 4
	i64 15582737692548360875, ; 282: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 88
	i64 15609085926864131306, ; 283: System.dll => 0xd89e9cf3334914ea => 160
	i64 15661133872274321916, ; 284: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 159
	i64 15780813008624904780, ; 285: Blazored.Toast => 0xdb00b5d22df36a4c => 37
	i64 15783653065526199428, ; 286: el\Microsoft.Maui.Controls.resources => 0xdb0accd674b1c484 => 5
	i64 15930129725311349754, ; 287: Xamarin.GooglePlayServices.Tasks.dll => 0xdd1330956f12f3fa => 116
	i64 16056281320585338352, ; 288: ru\Microsoft.Maui.Controls.resources.dll => 0xded35eca8f3a9df0 => 24
	i64 16154507427712707110, ; 289: System => 0xe03056ea4e39aa26 => 160
	i64 16288847719894691167, ; 290: nb\Microsoft.Maui.Controls.resources => 0xe20d9cb300c12d5f => 18
	i64 16321164108206115771, ; 291: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 54
	i64 16467346005009053642, ; 292: Xamarin.Google.Android.DataTransport.TransportApi => 0xe487c3f19e0337ca => 111
	i64 16649148416072044166, ; 293: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 62
	i64 16677317093839702854, ; 294: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 93
	i64 16803648858859583026, ; 295: ms\Microsoft.Maui.Controls.resources.dll => 0xe9328d9b8ab93632 => 17
	i64 16890310621557459193, ; 296: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 155
	i64 16942731696432749159, ; 297: sk\Microsoft.Maui.Controls.resources => 0xeb20acb622a01a67 => 25
	i64 16998075588627545693, ; 298: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 91
	i64 17008137082415910100, ; 299: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 124
	i64 17020682463616072225, ; 300: Xamarin.Firebase.Crashlytics => 0xec359c856e8e7a21 => 105
	i64 17031351772568316411, ; 301: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 90
	i64 17062143951396181894, ; 302: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 128
	i64 17079998892748052666, ; 303: Microsoft.AspNetCore.Components.dll => 0xed08587fce5018ba => 39
	i64 17187273293601214786, ; 304: System.ComponentModel.Annotations.dll => 0xee8575ff9aa89142 => 127
	i64 17203614576212522419, ; 305: pl\Microsoft.Maui.Controls.resources.dll => 0xeebf844ef3e135b3 => 20
	i64 17205988430934219272, ; 306: Microsoft.Extensions.FileSystemGlobbing => 0xeec7f35113509a08 => 52
	i64 17230721278011714856, ; 307: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 146
	i64 17310278548634113468, ; 308: hi\Microsoft.Maui.Controls.resources.dll => 0xf03a76a04e6695bc => 10
	i64 17342750010158924305, ; 309: hi\Microsoft.Maui.Controls.resources => 0xf0add33f97ecc211 => 10
	i64 17514990004910432069, ; 310: fr\Microsoft.Maui.Controls.resources => 0xf311be9c6f341f45 => 8
	i64 17522591619082469157, ; 311: GoogleGson => 0xf32cc03d27a5bf25 => 38
	i64 17580703809748094541, ; 312: Xamarin.GooglePlayServices.Measurement.Api => 0xf3fb34f7e9644e4d => 115
	i64 17623389608345532001, ; 313: pl\Microsoft.Maui.Controls.resources => 0xf492db79dfbef661 => 20
	i64 17704177640604968747, ; 314: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 89
	i64 17710060891934109755, ; 315: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 87
	i64 17712670374920797664, ; 316: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 148
	i64 17827813215687577648, ; 317: hr\Microsoft.Maui.Controls.resources.dll => 0xf7691da9f3129030 => 11
	i64 17942426894774770628, ; 318: de\Microsoft.Maui.Controls.resources.dll => 0xf9004e329f771bc4 => 4
	i64 17945795017270165205, ; 319: Xamarin.Google.Android.DataTransport.TransportApi.dll => 0xf90c457cc05cfed5 => 111
	i64 17986907704309214542, ; 320: Xamarin.GooglePlayServices.Basement.dll => 0xf99e554223166d4e => 114
	i64 18025913125965088385, ; 321: System.Threading => 0xfa28e87b91334681 => 157
	i64 18121036031235206392, ; 322: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 90
	i64 18245806341561545090, ; 323: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 123
	i64 18305135509493619199, ; 324: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 92
	i64 18324163916253801303, ; 325: it\Microsoft.Maui.Controls.resources => 0xfe4c81ff0a56ab57 => 14
	i64 18337470502355292274, ; 326: Xamarin.Firebase.Messaging => 0xfe7bc8440c175072 => 109
	i64 18342408478508122430, ; 327: id\Microsoft.Maui.Controls.resources.dll => 0xfe8d53543697013e => 13
	i64 18358161419737137786, ; 328: he\Microsoft.Maui.Controls.resources.dll => 0xfec54a8ba8b6827a => 9
	i64 18380184030268848184 ; 329: Xamarin.AndroidX.VersionedParcelable => 0xff1387fe3e7b7838 => 97
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [330 x i32] [
	i32 73, ; 0
	i32 56, ; 1
	i32 164, ; 2
	i32 61, ; 3
	i32 136, ; 4
	i32 95, ; 5
	i32 78, ; 6
	i32 64, ; 7
	i32 120, ; 8
	i32 50, ; 9
	i32 113, ; 10
	i32 156, ; 11
	i32 130, ; 12
	i32 12, ; 13
	i32 83, ; 14
	i32 37, ; 15
	i32 112, ; 16
	i32 69, ; 17
	i32 91, ; 18
	i32 101, ; 19
	i32 135, ; 20
	i32 103, ; 21
	i32 141, ; 22
	i32 58, ; 23
	i32 163, ; 24
	i32 156, ; 25
	i32 76, ; 26
	i32 88, ; 27
	i32 138, ; 28
	i32 145, ; 29
	i32 57, ; 30
	i32 75, ; 31
	i32 6, ; 32
	i32 95, ; 33
	i32 28, ; 34
	i32 35, ; 35
	i32 59, ; 36
	i32 87, ; 37
	i32 70, ; 38
	i32 83, ; 39
	i32 123, ; 40
	i32 43, ; 41
	i32 86, ; 42
	i32 153, ; 43
	i32 79, ; 44
	i32 151, ; 45
	i32 74, ; 46
	i32 27, ; 47
	i32 46, ; 48
	i32 2, ; 49
	i32 57, ; 50
	i32 7, ; 51
	i32 112, ; 52
	i32 85, ; 53
	i32 143, ; 54
	i32 118, ; 55
	i32 102, ; 56
	i32 48, ; 57
	i32 114, ; 58
	i32 61, ; 59
	i32 44, ; 60
	i32 115, ; 61
	i32 96, ; 62
	i32 161, ; 63
	i32 22, ; 64
	i32 151, ; 65
	i32 45, ; 66
	i32 159, ; 67
	i32 44, ; 68
	i32 94, ; 69
	i32 42, ; 70
	i32 53, ; 71
	i32 51, ; 72
	i32 59, ; 73
	i32 142, ; 74
	i32 138, ; 75
	i32 150, ; 76
	i32 3, ; 77
	i32 147, ; 78
	i32 72, ; 79
	i32 33, ; 80
	i32 130, ; 81
	i32 68, ; 82
	i32 136, ; 83
	i32 129, ; 84
	i32 116, ; 85
	i32 64, ; 86
	i32 28, ; 87
	i32 40, ; 88
	i32 97, ; 89
	i32 135, ; 90
	i32 103, ; 91
	i32 127, ; 92
	i32 74, ; 93
	i32 96, ; 94
	i32 149, ; 95
	i32 72, ; 96
	i32 18, ; 97
	i32 26, ; 98
	i32 125, ; 99
	i32 122, ; 100
	i32 125, ; 101
	i32 41, ; 102
	i32 149, ; 103
	i32 67, ; 104
	i32 26, ; 105
	i32 29, ; 106
	i32 133, ; 107
	i32 152, ; 108
	i32 99, ; 109
	i32 106, ; 110
	i32 23, ; 111
	i32 154, ; 112
	i32 6, ; 113
	i32 34, ; 114
	i32 119, ; 115
	i32 86, ; 116
	i32 100, ; 117
	i32 73, ; 118
	i32 7, ; 119
	i32 11, ; 120
	i32 63, ; 121
	i32 82, ; 122
	i32 55, ; 123
	i32 66, ; 124
	i32 105, ; 125
	i32 19, ; 126
	i32 158, ; 127
	i32 143, ; 128
	i32 42, ; 129
	i32 146, ; 130
	i32 108, ; 131
	i32 137, ; 132
	i32 129, ; 133
	i32 69, ; 134
	i32 158, ; 135
	i32 144, ; 136
	i32 65, ; 137
	i32 140, ; 138
	i32 161, ; 139
	i32 117, ; 140
	i32 14, ; 141
	i32 76, ; 142
	i32 71, ; 143
	i32 25, ; 144
	i32 107, ; 145
	i32 40, ; 146
	i32 126, ; 147
	i32 85, ; 148
	i32 139, ; 149
	i32 132, ; 150
	i32 16, ; 151
	i32 162, ; 152
	i32 126, ; 153
	i32 62, ; 154
	i32 152, ; 155
	i32 31, ; 156
	i32 93, ; 157
	i32 109, ; 158
	i32 145, ; 159
	i32 162, ; 160
	i32 92, ; 161
	i32 21, ; 162
	i32 132, ; 163
	i32 104, ; 164
	i32 106, ; 165
	i32 108, ; 166
	i32 31, ; 167
	i32 110, ; 168
	i32 67, ; 169
	i32 99, ; 170
	i32 75, ; 171
	i32 5, ; 172
	i32 29, ; 173
	i32 155, ; 174
	i32 79, ; 175
	i32 124, ; 176
	i32 1, ; 177
	i32 164, ; 178
	i32 113, ; 179
	i32 60, ; 180
	i32 140, ; 181
	i32 147, ; 182
	i32 58, ; 183
	i32 3, ; 184
	i32 19, ; 185
	i32 82, ; 186
	i32 118, ; 187
	i32 120, ; 188
	i32 80, ; 189
	i32 1, ; 190
	i32 50, ; 191
	i32 33, ; 192
	i32 141, ; 193
	i32 65, ; 194
	i32 54, ; 195
	i32 60, ; 196
	i32 49, ; 197
	i32 12, ; 198
	i32 27, ; 199
	i32 8, ; 200
	i32 98, ; 201
	i32 39, ; 202
	i32 15, ; 203
	i32 55, ; 204
	i32 78, ; 205
	i32 81, ; 206
	i32 36, ; 207
	i32 148, ; 208
	i32 13, ; 209
	i32 98, ; 210
	i32 53, ; 211
	i32 121, ; 212
	i32 107, ; 213
	i32 68, ; 214
	i32 104, ; 215
	i32 30, ; 216
	i32 119, ; 217
	i32 36, ; 218
	i32 66, ; 219
	i32 51, ; 220
	i32 52, ; 221
	i32 71, ; 222
	i32 154, ; 223
	i32 70, ; 224
	i32 150, ; 225
	i32 84, ; 226
	i32 89, ; 227
	i32 34, ; 228
	i32 77, ; 229
	i32 134, ; 230
	i32 56, ; 231
	i32 0, ; 232
	i32 43, ; 233
	i32 21, ; 234
	i32 122, ; 235
	i32 121, ; 236
	i32 163, ; 237
	i32 9, ; 238
	i32 117, ; 239
	i32 30, ; 240
	i32 48, ; 241
	i32 94, ; 242
	i32 35, ; 243
	i32 128, ; 244
	i32 110, ; 245
	i32 131, ; 246
	i32 84, ; 247
	i32 77, ; 248
	i32 157, ; 249
	i32 100, ; 250
	i32 23, ; 251
	i32 101, ; 252
	i32 142, ; 253
	i32 24, ; 254
	i32 32, ; 255
	i32 153, ; 256
	i32 2, ; 257
	i32 46, ; 258
	i32 16, ; 259
	i32 15, ; 260
	i32 32, ; 261
	i32 63, ; 262
	i32 102, ; 263
	i32 81, ; 264
	i32 38, ; 265
	i32 0, ; 266
	i32 47, ; 267
	i32 134, ; 268
	i32 139, ; 269
	i32 144, ; 270
	i32 17, ; 271
	i32 133, ; 272
	i32 137, ; 273
	i32 22, ; 274
	i32 45, ; 275
	i32 80, ; 276
	i32 47, ; 277
	i32 41, ; 278
	i32 49, ; 279
	i32 131, ; 280
	i32 4, ; 281
	i32 88, ; 282
	i32 160, ; 283
	i32 159, ; 284
	i32 37, ; 285
	i32 5, ; 286
	i32 116, ; 287
	i32 24, ; 288
	i32 160, ; 289
	i32 18, ; 290
	i32 54, ; 291
	i32 111, ; 292
	i32 62, ; 293
	i32 93, ; 294
	i32 17, ; 295
	i32 155, ; 296
	i32 25, ; 297
	i32 91, ; 298
	i32 124, ; 299
	i32 105, ; 300
	i32 90, ; 301
	i32 128, ; 302
	i32 39, ; 303
	i32 127, ; 304
	i32 20, ; 305
	i32 52, ; 306
	i32 146, ; 307
	i32 10, ; 308
	i32 10, ; 309
	i32 8, ; 310
	i32 38, ; 311
	i32 115, ; 312
	i32 20, ; 313
	i32 89, ; 314
	i32 87, ; 315
	i32 148, ; 316
	i32 11, ; 317
	i32 4, ; 318
	i32 111, ; 319
	i32 114, ; 320
	i32 157, ; 321
	i32 90, ; 322
	i32 123, ; 323
	i32 92, ; 324
	i32 14, ; 325
	i32 109, ; 326
	i32 13, ; 327
	i32 9, ; 328
	i32 97 ; 329
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

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
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
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
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" }

; Metadata
!llvm.module.flags = !{!0, !1, !7, !8, !9, !10}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.1xx @ af27162bee43b7fecdca59b4f67aa8c175cbc875"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"branch-target-enforcement", i32 0}
!8 = !{i32 1, !"sign-return-address", i32 0}
!9 = !{i32 1, !"sign-return-address-all", i32 0}
!10 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
