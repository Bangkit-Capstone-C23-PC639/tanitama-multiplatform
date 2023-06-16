import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tanitama/core/commons/router.dart';
import 'package:tanitama/core/styles/theme_data.dart';
import 'package:tanitama/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tanitama/features/auth/presentation/login_screen.dart';
import 'package:tanitama/features/community/presentation/cubit/community_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/create_comment_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/create_post_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/delete_comment_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/delete_post_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_detail_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/post_image_picker_cubit.dart';
import 'package:tanitama/features/community/presentation/cubit/user_posts_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/delete_detection_history_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/detection_history_cubit.dart';
import 'package:tanitama/features/detection/presentation/cubit/image_picker_cubit.dart';
import 'package:tanitama/features/home/presentation/home_screen.dart';
import 'package:tanitama/injection.dart' as di;
import 'package:timeago/timeago.dart' as timeago;

void main() {
  di.init();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
              create: (_) => di.locator<AuthCubit>()..checkLoginState()),
          BlocProvider<DetectionCubit>(
              create: (_) => di.locator<DetectionCubit>()),
          BlocProvider<ImagePickerCubit>(
              create: (_) => di.locator<ImagePickerCubit>()),
          BlocProvider<DetectionHistoryCubit>(
              create: (_) => di.locator<DetectionHistoryCubit>()),
          BlocProvider<DeleteDetectionHistoryCubit>(
              create: (_) => di.locator<DeleteDetectionHistoryCubit>()),
          BlocProvider<CommunityCubit>(
              create: (_) => di.locator<CommunityCubit>()),
          BlocProvider<PostDetailCubit>(
              create: (_) => di.locator<PostDetailCubit>()),
          BlocProvider<CreateCommentCubit>(
              create: (_) => di.locator<CreateCommentCubit>()),
          BlocProvider<PostImagePickerCubit>(
              create: (_) => di.locator<PostImagePickerCubit>()),
          BlocProvider<UserPostsCubit>(
              create: (_) => di.locator<UserPostsCubit>()),
          BlocProvider<CreatePostCubit>(
              create: (_) => di.locator<CreatePostCubit>()),
          BlocProvider<DeletePostCubit>(
              create: (_) => di.locator<DeletePostCubit>()),
          BlocProvider<DeleteCommentCubit>(
              create: (_) => di.locator<DeleteCommentCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tani Tama',
          theme: themeData,
          builder: EasyLoading.init(),
          onGenerateRoute: RouterGenerator.generateRoute,
          home: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
            if (state is LoadingAuthState) {
              EasyLoading.show(status: 'Tunggu sebentar...');
            } else if (state is AuthErrorState) {
              EasyLoading.showError(state.message);
            }
          }, builder: (context, state) {
            if (state is LogedState) {
              EasyLoading.dismiss();
              return const HomeScreen();
            }

            return LoginScreen();
          }),
        ));
  }
}
