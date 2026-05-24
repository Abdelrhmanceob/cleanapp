---
name: Aura Gilded Luxury
colors:
  surface: '#fcf9f8'
  surface-dim: '#dcd9d9'
  surface-bright: '#fcf9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f2'
  surface-container: '#f0edec'
  surface-container-high: '#ebe7e7'
  surface-container-highest: '#e5e2e1'
  on-surface: '#1c1b1b'
  on-surface-variant: '#4c4633'
  inverse-surface: '#313030'
  inverse-on-surface: '#f3f0ef'
  outline: '#7e7761'
  outline-variant: '#cfc6ac'
  surface-tint: '#705d00'
  primary: '#705d00'
  on-primary: '#ffffff'
  primary-container: '#e6c21a'
  on-primary-container: '#615000'
  inverse-primary: '#e8c41d'
  secondary: '#715c00'
  on-secondary: '#ffffff'
  secondary-container: '#fcd000'
  on-secondary-container: '#6e5a00'
  tertiary: '#725c00'
  on-tertiary: '#ffffff'
  tertiary-container: '#e5c24b'
  on-tertiary-container: '#634f00'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffe170'
  primary-fixed-dim: '#e8c41d'
  on-primary-fixed: '#221b00'
  on-primary-fixed-variant: '#544600'
  secondary-fixed: '#ffe17a'
  secondary-fixed-dim: '#ecc300'
  on-secondary-fixed: '#231b00'
  on-secondary-fixed-variant: '#554500'
  tertiary-fixed: '#ffe081'
  tertiary-fixed-dim: '#e7c34d'
  on-tertiary-fixed: '#231b00'
  on-tertiary-fixed-variant: '#564500'
  background: '#fcf9f8'
  on-background: '#1c1b1b'
  surface-variant: '#e5e2e1'
typography:
  display-lg:
    fontFamily: Poppins
    fontSize: 48px
    fontWeight: '800'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Poppins
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Poppins
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Poppins
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Poppins
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Poppins
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-lg:
    fontFamily: Poppins
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.05em
  label-md:
    fontFamily: Poppins
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 24px
  lg: 48px
  xl: 64px
  container-margin-mobile: 20px
  container-margin-desktop: 80px
  gutter: 16px
---

## Brand & Style

The brand personality is rooted in the concept of "The Golden Standard" of domestic care. It targets high-net-worth individuals and busy professionals who view cleaning not just as a chore, but as an essential luxury service that restores peace and order to their private sanctuaries.

The design style is **Modern Luxury with a Minimalist execution**. It leverages the high-contrast relationship between deep obsidian tones and warm gold accents to evoke a sense of exclusivity and prestige. The interface should feel like a high-end hotel concierge: effortless, pristine, and sophisticated. We use generous whitespace (breathing room) and refined "Golden Ratio" proportions to ensure the UI feels calm rather than cluttered.

## Colors

The palette is anchored by "Warm Gold" (#E6C21A), used strategically for primary actions and key brand moments. 

- **Primary Light/Dark:** Transition between #E6C21A and #F3CF57 to maintain luminosity across different background values.
- **Backgrounds:** Use the "Warm Light Beige" (#F6F4EE) for light mode to avoid the sterile clinical feel of pure white, moving to "Deep Black" (#121314) for a cinematic dark mode experience.
- **Surfaces:** Elevated cards use "Creamy White" or "Dark Gray" to create subtle separation from the base background.
- **Borders:** Extremely thin (1px) borders in "Light Beige" or "Dark Brown" act as elegant dividers without adding visual noise.

## Typography

This design system utilizes **Poppins** for its geometric clarity and modern friendliness, paired with **Cairo** for the Arabic localized experience to maintain a harmonious weight across scripts.

- **Display & Headlines:** Use ExtraBold (800) or Bold (700) for high-impact numbers (prices, square footage) and section titles.
- **Labels:** Use SemiBold (600) with increased letter spacing and uppercase styling for small metadata or category labels to give an "editorial" look.
- **Body:** Maintain Regular (400) for long-form descriptions to ensure maximum readability against the high-contrast backgrounds.

## Layout & Spacing

The layout philosophy follows a **Fixed-Fluid Hybrid** model. For mobile, a single-column layout with 20px side margins is standard. For desktop/web, a 12-column grid is used with a maximum content width of 1280px to maintain the premium feel of centered, focused content.

Spacing is aggressive and intentional. We avoid "tight" layouts; if a section is important, it is given significant vertical padding (48px or 64px) to signal its importance. Components are grouped using an 8px base grid, where `md` (24px) is the default padding for cards and containers.

## Elevation & Depth

To maintain a "Premium" feel, we eschew heavy, fuzzy shadows in favor of **Tonal Layering** and **Micro-Shadows**.

1.  **Level 0 (Base):** Background color.
2.  **Level 1 (Surface):** Surface color with a 1px solid border (#D7D0BD / #37342C).
3.  **Level 2 (Floating):** Used for primary buttons and active modals. A sharp 4px offset shadow with very low opacity (5-10%) colored with a hint of the primary gold to create a "glow" effect rather than a dark shadow.

In dark mode, depth is conveyed through "Lustre": using subtle linear gradients on surfaces (Top: 100% Surface Dark, Bottom: 95% Surface Dark) to simulate a physical material like polished stone or matte metal.

## Shapes

The shape language is **"Soft-Tailored"**. We use a `roundedness: 1` (4px to 12px radius) setting. 

- **Buttons & Inputs:** Use a 4px (Soft) radius to maintain a structural, architectural feel that communicates reliability.
- **Cards & Modals:** Use an 8px or 12px (rounded-lg) radius to feel approachable and modern.
- **Icons:** Should be encased in circular or soft-square containers with a 1px border.

Avoid fully rounded "pill" shapes for primary buttons, as they can feel too "casual" for a luxury service. Instead, stick to soft-rectangles.

## Components

### Buttons
- **Primary:** Background #E6C21A, Text #141414, Bold weight. High-gloss finish.
- **Secondary:** Transparent background, 1px border #E6C21A, Text #E6C21A.
- **Ghost:** Text #666157 (Light Mode) or #BBB5A5 (Dark Mode), no border.

### Input Fields
- Labels are always `label-lg` (uppercase). 
- Fields use the Surface color with a 1px border. On focus, the border changes to Primary Gold.

### Cards
- Standard Service Card: Features a high-resolution image with a subtle 10% black overlay at the bottom to support white typography.
- Information Card: Minimalist, uses `surface` background and `border` for definition.

### Booking Timeline
- Use a vertical "Thread" component. Completed steps are Primary Gold, upcoming steps are Border color.

### Quality Badges
- Small chips using `Secondary Decor` (#FFD300) with 85% opacity to highlight "Pro Cleaners" or "Luxury Tier" options.