import 'package:dartz/dartz.dart';

import '../../../../core/constants/failures.dart';
import '../../data/model/profile_model.dart';

abstract class ProfileRepository{
  Future<Either<Failure,ProfileModel>>getProfile();
}