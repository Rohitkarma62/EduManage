import 'package:edumanage_offline/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the EduManage Offline bootstrap screen', (tester) async {
    await tester.pumpWidget(const EduManageApp());

    expect(find.text('EduManage Offline'), findsOneWidget);
    expect(find.text('Your institute, managed offline.'), findsOneWidget);
    expect(find.textContaining('Project foundation is being set up.'), findsOneWidget);
  });
}
