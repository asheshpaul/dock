import '../entities/icon_entity.dart';
import '../../data/repositories/icon_repository.dart';

class GetIconsUseCase {
  final IconRepository repository;

  GetIconsUseCase(this.repository);

  List<IconEntity> execute() {
    return repository.icons.map((iconModel) => IconEntity(icon: iconModel.icon)).toList();
  }
}
