I want a clean, minimal architecture using **GetX** with **MVVM-like separation** and **dependency injection**.  
The structure must be:

lib/
  core/
    network/         // ApiClient, interceptors
    di/              // app_bindings.dart (global deps)
  features/
    <feature_name>/
      data/          // repositories
      models.dart    // Equatable models
      presentation/  // controllers + pages
      <feature>_binding.dart

Rules:
1. **Networking**: Use `http` package.  
   - ApiClient handles GET, POST, PUT, DELETE.  
   - Base URL from constants.  
   - Automatically include auth token from FlutterSecureStorage if available.

2. **State management**: Use `GetX` controllers.  
   - Controllers only call repositories and manage reactive state.
   - Use `.obs` and `Rxn<T>` where needed.
   - Always navigate with `Get.offAllNamed`, `Get.toNamed`, or `Get.back`.

3. **Routing**: Centralized in `app_routes.dart`.  
   - Each feature gets its own Binding for DI.  
   - Bindings inject repository + controller.

4. **Storage**:  
   - Sensitive data (tokens) → `FlutterSecureStorage`  
   - Non-sensitive prefs → `SharedPreferences`

5. **Models**:  
   - Use `equatable` for value equality.  
   - Write factory `.fromJson` and `.toJson` manually, no codegen.

6. **Error handling**:  
   - Simple try/catch in repository methods, return `null` or empty list on failure.  
   - Show errors via `Get.snackbar`.

7. **No codegen or fancy layers**:  
   - No freezed, json_serializable, retrofit.  
   - Keep it lean and explicit.

8. **Auth Example Reference**:  
   Use the following flow as a reference for *all features*:


Repository: 

   class AuthRepository {
     final ApiClient api;
     final FlutterSecureStorage secureStorage;
     AuthRepository(this.api, this.secureStorage);

     Future<User?> login(String email, String password) async {
       final res = await api.post('/auth/login', {
         'email': email,
         'password': password,
       });
       if (res.statusCode == 200) {
         final data = jsonDecode(res.body);
         await secureStorage.write(key: 'accessToken', value: data['access']);
         await secureStorage.write(key: 'refreshToken', value: data['refresh']);
         return User.fromJson(data['user']);
       }
       return null;
     }

     Future<void> logout() async => await secureStorage.deleteAll();
   }


Model:

class User extends Equatable {
  final String id;
  final String email;
  final String name;

  const User({required this.id, required this.email, required this.name});
  factory User.fromJson(Map<String, dynamic> json) =>
    User(id: json['id'], email: json['email'], name: json['name']);
  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name};
  @override
  List<Object?> get props => [id, email, name];
}

Controller:


class AuthController extends GetxController {
  final AuthRepository repo;
  AuthController(this.repo);
  final isLoading = false.obs;
  final user = Rxn<User>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await repo.login(email, password);
    isLoading.value = false;
    if (result != null) {
      user.value = result;
      Get.offAllNamed('/profile');
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }

  void logout() {
    repo.logout();
    user.value = null;
    Get.offAllNamed('/login');
  }
}

Binding:


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository(Get.find(), Get.find()));
    Get.lazyPut(() => AuthController(Get.find()));
  }
}

Page:

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final emailC = TextEditingController();
    final passC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailC, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passC, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => controller.login(emailC.text, passC.text),
                    child: const Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }
}

Use this same pattern for every feature:

Add models in models.dart
Add repository in data/
Add controller + UI in presentation/
Add binding in <feature>_binding.dart
Add routes in app_routes.dart
Add all DI in global app_bindings.dart

When I give you a new feature name, generate all files in that format.