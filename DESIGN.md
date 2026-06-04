---
name: Premium Egyptian Maintenance
colors:
  surface: '#fff8ef'
  surface-dim: '#e3d9c0'
  surface-bright: '#fff8ef'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fef3d8'
  surface-container: '#f8edd3'
  surface-container-high: '#f2e7cd'
  surface-container-highest: '#ece2c8'
  on-surface: '#201b0b'
  on-surface-variant: '#4d4632'
  inverse-surface: '#35301f'
  inverse-on-surface: '#fbf0d6'
  outline: '#7f775f'
  outline-variant: '#d0c6ab'
  surface-tint: '#715c00'
  primary: '#715c00'
  on-primary: '#ffffff'
  primary-container: '#fcd000'
  on-primary-container: '#6e5900'
  inverse-primary: '#ecc300'
  secondary: '#605e5e'
  on-secondary: '#ffffff'
  secondary-container: '#e6e1e1'
  on-secondary-container: '#666464'
  tertiary: '#5f5e5e'
  on-tertiary: '#ffffff'
  tertiary-container: '#d6d3d2'
  on-tertiary-container: '#5c5b5a'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffe17b'
  primary-fixed-dim: '#ecc300'
  on-primary-fixed: '#231b00'
  on-primary-fixed-variant: '#564500'
  secondary-fixed: '#e6e1e1'
  secondary-fixed-dim: '#c9c6c5'
  on-secondary-fixed: '#1c1b1b'
  on-secondary-fixed-variant: '#484646'
  tertiary-fixed: '#e4e2e1'
  tertiary-fixed-dim: '#c8c6c5'
  on-tertiary-fixed: '#1b1c1b'
  on-tertiary-fixed-variant: '#474746'
  background: '#fff8ef'
  on-background: '#201b0b'
  surface-variant: '#ece2c8'
typography:
  headline-xl:
    fontFamily: Cairo
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 52px
  headline-lg:
    fontFamily: Cairo
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Cairo
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Cairo
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  body-lg:
    fontFamily: Cairo
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Cairo
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Poppins
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Poppins
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.04em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 24px
  lg: 48px
  xl: 80px
  gutter: 20px
  margin-mobile: 16px
  margin-desktop: 64px
---

## Brand & Style

This design system is crafted for a premium Egyptian service context, blending the warmth of local hospitality with the clinical precision of modern hygiene standards. The personality is professional and dependable, yet approachable.

The visual style is a **Modern-Material** hybrid. It utilizes Google’s Material Design principles—specifically its focus on surface elevation and intentional motion—but softens them with a bespoke color palette and generous whitespace. The interface must feel "spotless," utilizing light surfaces to evoke a sense of cleanliness and luxury. As an Egyptian-first product, the layout is designed with a **Right-to-Left (RTL)** priority, ensuring that visual flow, iconography, and navigation are optimized for Arabic-speaking users.

## Colors

The palette is anchored by a high-energy **Primary Yellow (#FCD000)**, symbolizing brightness, energy, and the "sparkle" of a clean space. This is balanced by a **Soft Cream Surface (#FCF9F8)**, which provides a warmer, more premium feel than a clinical pure white, reducing eye strain and adding an editorial touch.

- **Primary Yellow**: Used for call-to-actions, brand accents, and active states.
- **Text Heading (Ebony)**: A deep, near-black neutral used for hierarchy and high-contrast readability.
- **Text Body (Olive-Drab)**: A softer, earthy neutral for long-form text, creating a sophisticated tonal relationship with the cream background.
- **Surface**: The soft cream is used for page backgrounds, while pure white is reserved for cards and elevated components to create subtle "tone-on-tone" depth.

## Typography

The typography system is bilingual and highly hierarchical. 
- **Cairo** is the primary typeface, selected for its wide range of weights and excellent legibility in Arabic script. It is used for all headings and body text to maintain cultural resonance.
- **Poppins** is employed as a secondary "functional" typeface. It is used exclusively for English labels, numerals, and technical data (like price tags or timestamps), providing a geometric, modern contrast to the organic curves of the Arabic script.

Headlines should use the ExtraBold (800) or Bold (700) weights to establish authority, while body text remains in Regular (400) for maximum readability against the cream backgrounds.

## Layout & Spacing

The layout follows a **Fluid Grid** model with an 8px base unit. 
- **Mobile**: A 4-column grid with 16px side margins. 
- **Desktop**: A 12-column grid with a maximum content width of 1280px and 64px side margins.

Spacing is "generous" to reflect a sense of order and room to breathe. Components should use 24px (md) padding as a default to prevent visual clutter. In RTL mode, all horizontal spacing logic is inverted: margins on the left become margins on the right, and the directional flow of "Next" or "Back" buttons must be mirrored (e.g., "Next" points to the left).

## Elevation & Depth

This design system uses **Tonal Layers** combined with **Ambient Shadows** to create a sense of tactile premium quality. 

1. **Level 0 (Base)**: Soft Cream (#FCF9F8).
2. **Level 1 (Card)**: Pure White (#FFFFFF) with a subtle 1px border in a slightly darker cream tone or a very soft shadow.
3. **Level 2 (Active/Floating)**: Pure White with an 8px to 16px blur radius shadow. The shadow color should not be pure black; instead, use a tinted neutral (e.g., `rgba(76, 70, 51, 0.08)`) to maintain the warm aesthetic.

Avoid heavy borders. Depth should feel natural, like paper stacked on a clean surface.

## Shapes

The shape language is friendly and soft, avoiding sharp corners to evoke safety and care.
- **Standard Components**: Buttons and Input fields use a 12px (`rounded-lg`) radius.
- **Containers**: Large cards and modals use a 24px (`rounded-xl`) radius.
- **Small Elements**: Chips and tags use a full pill-shape to contrast against the structured grid.

Icons should follow a "Rounded" or "Duo-tone" style to match the thickness of the Cairo typeface.

## Components

### Buttons
- **Primary**: Solid Primary Yellow with Text Heading (#1C1B1B) labels. 12px corner radius. High-contrast and bold.
- **Secondary**: Ghost style with an Ebony outline or a Soft Cream fill.
- **State**: On press, the Primary Yellow should darken slightly to indicate interaction.

### Input Fields
- Background should be Pure White. 
- Borders are 1px solid in a light-neutral shade, turning Primary Yellow on focus. 
- Labels appear above the field in Cairo Bold, while placeholder text uses Cairo Regular.

### Cards
- Always use a White background to "pop" against the Cream surface. 
- Use 24px internal padding. 
- Apply Level 1 elevation (soft shadow) to distinguish from the background.

### Chips & Status
- Use pill shapes for service categories (e.g., "Deep Cleaning," "Pest Control").
- Use the Primary Yellow for "Selected" states and a very light version of the body text color for "Inactive" states.

### Lists
- Use horizontal dividers with a low-opacity (10%) version of the Text Body color.
- In RTL, icons (like "Chevron-Left" for navigation) must be mirrored.