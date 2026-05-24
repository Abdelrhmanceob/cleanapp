---
name: Gilded Minimalist
colors:
  surface: '#FFFEFA'
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
  secondary: '#635e4f'
  on-secondary: '#ffffff'
  secondary-container: '#e7dfcc'
  on-secondary-container: '#676253'
  tertiary: '#006d3f'
  on-tertiary: '#ffffff'
  tertiary-container: '#7ad89e'
  on-tertiary-container: '#005e36'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffe170'
  primary-fixed-dim: '#e8c41d'
  on-primary-fixed: '#221b00'
  on-primary-fixed-variant: '#544600'
  secondary-fixed: '#e9e2cf'
  secondary-fixed-dim: '#cdc6b3'
  on-secondary-fixed: '#1e1c10'
  on-secondary-fixed-variant: '#4b4738'
  tertiary-fixed: '#97f6ba'
  tertiary-fixed-dim: '#7cda9f'
  on-tertiary-fixed: '#002110'
  on-tertiary-fixed-variant: '#00522f'
  background: '#F6F4EE'
  on-background: '#1c1b1b'
  surface-variant: '#e5e2e1'
  border-subtle: '#D7D0BD'
typography:
  display-lg:
    fontFamily: Playfair Display
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Playfair Display
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Playfair Display
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Playfair Display
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  title-lg:
    fontFamily: Outfit
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Outfit
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Outfit
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Outfit
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Outfit
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  margin-mobile: 20px
  gutter-mobile: 12px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
  inset-card: 16px
---

## Brand & Style

The design system is engineered to evoke a sense of **Exclusive Luxury** and **Modern Sophistication**. It targets a high-discerning audience that values precision, warmth, and high-end hospitality. The brand personality is poised and prestigious, yet fundamentally clean and accessible.

The chosen design style is **Minimalism with Tonal Layering**. By utilizing a palette of creams, beiges, and gold accents, the UI avoids the sterility of pure white minimalism in favor of a "Quiet Luxury" aesthetic. This approach prioritizes heavy whitespace, meticulous typographic hierarchy, and subtle depth through color-on-color layering rather than heavy shadows. The result is a digital environment that feels curated, calm, and premium.

## Colors

The color strategy for the design system centers on a high-contrast relationship between a deep **Dark Black** text and a warm **Cream/Beige** background. 

- **Primary Gold (#E6C21A):** Reserved for high-intent actions, primary buttons, and critical branding moments. It represents the "premium" nature of the service.
- **Secondary Beige (#D7D0BD):** Used for structural elements like borders, dividers, and inactive states to maintain a soft, tonal look.
- **Surface & Background:** The dual-tone cream approach (`#F6F4EE` for the page and `#FFFEFA` for cards) creates depth without relying on shadows.
- **Success Green:** A muted, sophisticated emerald that communicates confirmation without clashing with the gold-based palette.

## Typography

This design system uses a sophisticated pairing of **Playfair Display** for headlines and **Outfit** for functional text. This combination bridges the gap between traditional luxury and modern digital efficiency.

- **Headlines:** Set in Playfair Display. Use high weights (600+) to emphasize the serif's elegant contrast. For mobile screens, use `headline-lg-mobile` to prevent excessive wrapping.
- **Body & Functional Text:** Set in Outfit. Its geometric but open letterforms provide excellent legibility on mobile screens at smaller sizes.
- **Labels:** Always utilize a slight letter-spacing increase and uppercase transformation for labels and badges to create a distinct "utility" feel that contrasts with the fluid headlines.

## Layout & Spacing

The design system follows a **8pt spacing rhythm** to ensure mathematical harmony across all screen sizes. 

- **Mobile Grid:** A fluid 4-column grid with 20px outside margins and 12px gutters.
- **Vertical Rhythm:** Elements are stacked using multiples of 8px. Use `stack-lg` (32px) between major sections to maintain the "High-end" airy feel.
- **Safe Areas:** Ensure all critical actions (like primary buttons) are placed within a 20px safe-zone from the screen edges. Content should utilize dynamic padding based on the device width, but never drop below the 20px margin.

## Elevation & Depth

To maintain the "Luxury" aesthetic, the design system avoids heavy, dark shadows. Depth is achieved through **Tonal Layering** and **Ambient Glows**:

1.  **Level 0 (Base):** The Cream Background (`#F6F4EE`).
2.  **Level 1 (Surface):** The White Cream Surface (`#FFFEFA`). Used for cards and input containers. These should use a very soft, diffused shadow: `0px 4px 20px rgba(20, 20, 20, 0.04)`.
3.  **Level 2 (Active):** Interactive elements like primary buttons. When hovered or pressed, they may emit a subtle "Gold Glow" using a low-opacity shadow tinted with the primary color (`rgba(230, 194, 26, 0.2)`).
4.  **Glassmorphism:** Navigation bars and sticky headers should use a backdrop blur (20px) with a semi-transparent White Cream background (`rgba(255, 254, 250, 0.8)`) to maintain context while scrolling.

## Shapes

The design system utilizes **Rounded** geometry (0.5rem base) to convey a sense of comfort and high-end approachability. 

- **Standard Elements:** Input fields, small buttons, and chips use `0.5rem` (8px).
- **Cards & Modals:** Large containers use `rounded-lg` (1rem / 16px) to emphasize their role as distinct surfaces.
- **Specialty Elements:** Interactive maps and search bars may utilize `rounded-xl` (1.5rem / 24px) to feel more "tactile" and distinct from structural UI.

## Components

- **Buttons:** 
  - *Primary:* Solid Golden (`#E6C21A`) background with Dark Black (`#141414`) text. On hover/active, apply a 10% black overlay to deepen the gold.
  - *Secondary:* Transparent background with a 1px border of `#D7D0BD`.
- **Input Fields:** White Cream (`#FFFEFA`) surfaces with a 1px border of `#D7D0BD`. Focus state switches the border to Gold (`#E6C21A`).
- **Cards:** Use White Cream surfaces with the defined Level 1 soft shadow. No borders are necessary if the contrast against the Cream background is sufficient.
- **Badges/Chips:** Small, uppercase text in `label-sm`. Use a light beige background (`#D7D0BD` at 20% opacity) with Dark Black text.
- **Map Elements:** Map pins should use the Primary Gold color with a white stroke. Information tooltips on maps should follow the Card styling (White Cream + soft shadow).
- **Selection Controls:** Checkboxes and Radios use a Gold fill when active, ensuring high visibility against the light background.