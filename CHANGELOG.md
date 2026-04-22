## [1.2.2] - 22-04-2026

- **Updated:** Dark and Light mode support

## [1.2.1] - 02-04-2026

- **Changed:** Default loading style from `cupertinoBox` to `pulseRing`
- **Updated:** Flutter minimum version constraint for broader compatibility

## [1.2.0] - 2026-01-12

- **Added:** New `BlurredLoadingOverlay` widget for displaying loading states with blur effect
- **Added:** New `BlurredLoadingPercentage` widget for progress-based loading with percentage display
- **Added:** 20 loading styles available via `LoadingStyle` enum:
  - `bouncingLineCircle/Square` - Three shapes bouncing smoothly
  - `bouncingGridCircle/Square` - 3x3 grid with diagonal bounce effect
  - `bumpingLineCircle/Square` - Three shapes with horizontal bump motion
  - `fadingLineCircle/Square` - Three shapes with sequential fade effect
  - `jumpingLineCircle/Square` - Three shapes jumping vertically
  - `rotatingSquare` - Single shape rotating 360 degrees
  - `flippingCircle/Square` - Single shape flipping horizontally 3 times
  - `doubleFlippingCircle/Square` - Shape flipping on X then Y axis
  - `fillingSquare` - Shape that fills and rotates while unfilling
  - `cupertinoBox` - iOS-style spinner in centered semi-transparent box (default)
  - `pulseRing` - Concentric rings expanding outward with fading opacity
  - `orbitDots` - Multiple dots orbiting around a center point
  - `breathingCircle` - Circle that smoothly expands and contracts
- **Added:** `customLoadingWidget` parameter for fully custom loading indicators
- **Added:** Header and footer widget slots for loading overlays
- **Added:** Line and circle progress styles for percentage-based loading
- **Enhanced:** Simplified API with `LoadingStyle` enum for easy animation selection

## [1.1.0] - 2025-11-12

- **Added:** New `BlurredDrawer` widget for creating blurred navigation drawers
- **Added:** Support for both left and right drawer positions via `DrawerPosition` enum
- **Added:** Customizable drawer parameters (blurSigma, width, backgroundColor, elevation, shadowColor, borderRadius)
- **Added:** Theme-aware drawer with automatic color fallbacks
- **Enhanced:** Updated example app to demonstrate BlurredDrawer usage
- **Enhanced:** Updated README with drawer screenshot and improved examples
- **Fixed:** Deprecated `withOpacity()` calls replaced with `withValues()` for Flutter compatibility

## [1.0.3] - 2025-08-30

- **Fixed:** Resolved yellow line artifact appearing in release mode by restructuring widget hierarchy
- **Fixed:** Corrected padding parameter bug (was using margin value instead)
- **Fixed:** Handle margin now properly defaults to top spacing
- **Enhanced:** Added new customization parameters (backgroundColor, barrierColor, maxHeight, enableDrag, useSafeArea)
- **Enhanced:** Improved layout system - removed fixed width, added proper constraints and flexible content wrapping
- **Enhanced:** Added subtle three-sided shadow (top, left, right) for better visual separation
- **Enhanced:** Simplified widget structure for better performance and maintainability
- **Enhanced:** Better theme integration with automatic color fallbacks

## [1.0.2] - 2025-08-06

- Added Demo Screenshot.
- Added handle in the bottom sheet.
- Added usage example code.
