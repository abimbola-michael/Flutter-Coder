import 'package:flutter_coder/features/converter/utils/react_code_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Tailwind function", () {
    final output = cssToTailwind("aspect-ratio", "1/1");
    expect(output, "aspect-auto");
  });
}
