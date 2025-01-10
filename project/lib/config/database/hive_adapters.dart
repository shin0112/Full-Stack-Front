import 'package:hive_ce/hive.dart';
import 'package:project/data/model/user.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<User>()])
void _() {}
