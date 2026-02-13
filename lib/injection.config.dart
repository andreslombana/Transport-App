// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:socket_io_client/socket_io_client.dart' as _i414;

import 'src/data/dataSource/local/SharefPref.dart' as _i499;
import 'src/data/dataSource/remote/services/AuthService.dart' as _i204;
import 'src/data/dataSource/remote/services/ClientRequestsService.dart'
    as _i574;
import 'src/data/dataSource/remote/services/DriverCarInfoService.dart' as _i353;
import 'src/data/dataSource/remote/services/DriversPositionService.dart'
    as _i85;
import 'src/data/dataSource/remote/services/DriverTripRequestsService.dart'
    as _i78;
import 'src/data/dataSource/remote/services/UsersService.dart' as _i430;
import 'src/data/repository/ClientRequestsRepositoryImpl.dart' as _i778;
import 'src/di/AppModule.dart' as _i199;
import 'src/domain/repository/AuthRepository.dart' as _i1048;
import 'src/domain/repository/ClientRequestsRepository.dart' as _i197;
import 'src/domain/repository/DriverCarInfoRepository.dart' as _i386;
import 'src/domain/repository/DriversPositionRepository.dart' as _i662;
import 'src/domain/repository/DriverTripRequestsRepository.dart' as _i716;
import 'src/domain/repository/GeolocatorRepository.dart' as _i58;
import 'src/domain/repository/SocketRepository.dart' as _i589;
import 'src/domain/repository/UsersRepository.dart' as _i562;
import 'src/domain/useCases/auth/AuthUseCases.dart' as _i396;
import 'src/domain/useCases/client-requests/CancelRequestUseCase.dart' as _i657;
import 'src/domain/useCases/client-requests/ClientRequestsUseCases.dart'
    as _i974;
import 'src/domain/useCases/client-requests/CreateClientRequestUseCase.dart'
    as _i290;
import 'src/domain/useCases/client-requests/GetByClientAssignedUseCase.dart'
    as _i628;
import 'src/domain/useCases/client-requests/GetByClientRequestUseCase.dart'
    as _i176;
import 'src/domain/useCases/client-requests/GetByDriverAssignedUseCase.dart'
    as _i249;
import 'src/domain/useCases/client-requests/GetNearbyTripRequestUseCase.dart'
    as _i346;
import 'src/domain/useCases/client-requests/GetTimeAndDistanceUseCase.dart'
    as _i294;
import 'src/domain/useCases/client-requests/UpdateClientRatingUseCase.dart'
    as _i661;
import 'src/domain/useCases/client-requests/UpdateDriverAssignedUseCase.dart'
    as _i945;
import 'src/domain/useCases/client-requests/UpdateDriverRatingUseCase.dart'
    as _i878;
import 'src/domain/useCases/client-requests/UpdateStatusClientRequestUseCase.dart'
    as _i824;
import 'src/domain/useCases/driver-car-info/DriverCarInfoUseCases.dart'
    as _i1049;
import 'src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart'
    as _i708;
import 'src/domain/useCases/drivers-position/DriversPositionUseCases.dart'
    as _i881;
import 'src/domain/useCases/geolocator/GeolocatorUseCases.dart' as _i260;
import 'src/domain/useCases/socket/SocketUseCases.dart' as _i28;
import 'src/domain/useCases/users/UsersUseCases.dart' as _i548;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i574.ClientRequestsService>(
        () => _i574.ClientRequestsService());
    gh.factory<_i499.SharefPref>(() => appModule.sharefPref);
    gh.factory<_i414.Socket>(() => appModule.socket);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i204.AuthService>(() => appModule.authService);
    gh.factory<_i430.UsersService>(() => appModule.usersService);
    gh.factory<_i85.DriversPositionService>(
        () => appModule.driversPositionService);
    gh.factory<_i78.DriverTripRequestsService>(
        () => appModule.driverTripRequestsService);
    gh.factory<_i353.DriverCarInfoService>(
        () => appModule.driverCarInfoService);
    gh.factory<_i1048.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i562.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i589.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i58.GeolocatorRepository>(() => appModule.geolocatorRepository);
    gh.factory<_i662.DriverPositionRepository>(
        () => appModule.driversPositionRepository);
    gh.factory<_i716.DriverTripRequestsRepository>(
        () => appModule.driverTripRequestsRepository);
    gh.factory<_i386.DriverCarInfoRepository>(
        () => appModule.driverCarInfoRepository);
    gh.factory<_i396.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i548.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i260.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i28.SocketUseCases>(() => appModule.socketUseCases);
    gh.factory<_i881.DriversPositionUseCases>(
        () => appModule.driversPositionUseCases);
    gh.factory<_i708.DriverTripRequestUseCases>(
        () => appModule.driverTripRequestUseCases);
    gh.factory<_i1049.DriverCarInfoUseCases>(
        () => appModule.driverCarInfoUseCases);
    gh.lazySingleton<_i197.ClientRequestsRepository>(() =>
        _i778.ClientRequestsRepositoryImpl(gh<_i574.ClientRequestsService>()));
    gh.factory<_i657.CancelRequestUseCase>(
        () => _i657.CancelRequestUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i628.GetByClientAssignedUseCase>(() =>
        _i628.GetByClientAssignedUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i290.CreateClientRequestUseCase>(() =>
        _i290.CreateClientRequestUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i176.GetByClientRequestUseCase>(() =>
        _i176.GetByClientRequestUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i249.GetByDriverAssignedUseCase>(() =>
        _i249.GetByDriverAssignedUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i346.GetNearbyTripRequestUseCase>(() =>
        _i346.GetNearbyTripRequestUseCase(
            gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i294.GetTimeAndDistanceUseCase>(() =>
        _i294.GetTimeAndDistanceUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i661.UpdateClientRatingUseCase>(() =>
        _i661.UpdateClientRatingUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i945.UpdateDriverAssignedUseCase>(() =>
        _i945.UpdateDriverAssignedUseCase(
            gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i878.UpdateDriverRatingUseCase>(() =>
        _i878.UpdateDriverRatingUseCase(gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i824.UpdateStatusClientRequestUseCase>(() =>
        _i824.UpdateStatusClientRequestUseCase(
            gh<_i197.ClientRequestsRepository>()));
    gh.factory<_i974.ClientRequestsUseCases>(() => _i974.ClientRequestsUseCases(
          createClientRequest: gh<_i290.CreateClientRequestUseCase>(),
          getTimeAndDistance: gh<_i294.GetTimeAndDistanceUseCase>(),
          getNearbyTripRequest: gh<_i346.GetNearbyTripRequestUseCase>(),
          updateDriverAssigned: gh<_i945.UpdateDriverAssignedUseCase>(),
          getByClientRequest: gh<_i176.GetByClientRequestUseCase>(),
          updateStatusClientRequest:
              gh<_i824.UpdateStatusClientRequestUseCase>(),
          updateClientRating: gh<_i661.UpdateClientRatingUseCase>(),
          updateDriverRating: gh<_i878.UpdateDriverRatingUseCase>(),
          getByClientAssigned: gh<_i628.GetByClientAssignedUseCase>(),
          getByDriverAssigned: gh<_i249.GetByDriverAssignedUseCase>(),
          cancelRequest: gh<_i657.CancelRequestUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i199.AppModule {}
