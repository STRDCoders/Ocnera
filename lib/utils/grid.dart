/// [SCREEN_SIZE_RESOLUTION] should match the indexes of the [ScreenSize].
const List<num> SCREEN_SIZE_RESOLUTION = [0, 310, 576, 768, 992, 1200, 2000];
enum ScreenSize {
  us,
// Smart watches
  xs,
// Small phones (5c)
  sm,
// Medium phones
  md,
// Large phones (iPhone X)
  lg,
// Tablets
  xl,
// Laptops
  ul
// Desktops and TVs 4K
}

extension ScreenSizeExtention on ScreenSize {}
