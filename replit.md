# DOPIK ELECTRONICS

## Overview

DOPIK ELECTRONICS is a premium e-commerce website for an electronics retail shop based in Kigali, Rwanda. The platform enables customers to browse and purchase refurbished and new electronics (iPhones, Samsung phones, laptops, audio equipment, accessories) with WhatsApp integration for order confirmation. The site features a customer-facing storefront with product catalog, search, and filtering, plus a secure admin dashboard for product and order management.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Framework**: React 18 with TypeScript, bundled via Vite
- **Routing**: Wouter (lightweight client-side routing)
- **State Management**: TanStack React Query for server state caching and synchronization
- **Styling**: Tailwind CSS with CSS variables for theming (dark/light mode support)
- **UI Components**: shadcn/ui component library (Radix UI primitives with custom styling)
- **Animations**: Framer Motion for page transitions and micro-interactions
- **Forms**: React Hook Form with Zod validation

### Backend Architecture
- **Runtime**: Node.js with Express.js
- **API Design**: RESTful JSON API with typed routes defined in `shared/routes.ts`
- **Session Management**: Express-session with MemoryStore (configurable for production with connect-pg-simple)
- **Authentication**: Custom password hashing using Node.js crypto (scrypt), session-based admin auth

### Data Layer
- **ORM**: Drizzle ORM with PostgreSQL dialect
- **Schema Location**: `shared/schema.ts` contains all table definitions
- **Migrations**: Drizzle Kit for schema migrations (`drizzle-kit push`)
- **Validation**: Drizzle-Zod for generating Zod schemas from database tables

### Project Structure
```
├── client/           # Frontend React application
│   ├── src/
│   │   ├── components/   # Reusable UI components
│   │   ├── pages/        # Route-level page components
│   │   ├── hooks/        # Custom React hooks
│   │   └── lib/          # Utilities and query client
├── server/           # Backend Express application
│   ├── routes.ts     # API route handlers
│   ├── storage.ts    # Database access layer
│   └── auth.ts       # Authentication utilities
├── shared/           # Shared code between client/server
│   ├── schema.ts     # Database schema definitions
│   └── routes.ts     # API route type definitions
```

### Key Design Patterns
- **Shared Types**: Database schemas and API contracts are defined in `shared/` and imported by both client and server
- **Storage Interface**: `IStorage` interface in `server/storage.ts` abstracts database operations for testability
- **Theme System**: CSS variables with Tailwind's `dark:` variant, persisted to localStorage with system preference fallback

## External Dependencies

### Database
- **PostgreSQL**: Primary database, connection via `DATABASE_URL` environment variable
- **Drizzle ORM**: Type-safe database queries and migrations

### Third-Party Services
- **WhatsApp Business**: Order confirmation and customer support via `wa.me` URL scheme (no API integration, direct linking)

### Key NPM Packages
- `@tanstack/react-query`: Server state management
- `drizzle-orm` / `drizzle-kit`: Database ORM and migrations
- `express-session` / `memorystore`: Session management
- `zod`: Runtime validation for API inputs and forms
- `framer-motion`: Animation library
- `wouter`: Lightweight React router
- `lucide-react`: Icon library

### Environment Variables Required
- `DATABASE_URL`: PostgreSQL connection string
- `SESSION_SECRET`: Secret key for session encryption (optional, has default)

## Features & Recent Updates

### Categories Expansion + Hot Deals Manager (Latest)
- **New Categories Added**: "Laptop Accessories", "Gaming Accessories", "Camera Accessories" in both admin add/edit product forms and the Shop page filter sidebar
- **"Other" Dropdown Bug Fixed**: Selecting "Other" for Category, Brand, or Gaming Subcategory now correctly keeps the custom text input visible while typing (fixed using separate raw selection state)
- **Hot Deals Manager**: New admin page to promote products as time-limited deals
  - Set discount percentages (0–90%) per product
  - Inline toggle/edit per row with live deal price preview
  - The Deals page (`/deals`) now shows only admin-marked hot deals with real prices
  - `isHotDeal` and `hotDealDiscount` columns added to products table
- **Admin Sidebar**: "Hot Deals" item added with Flame icon

### Admin Dashboard Mobile Navigation
- **Bottom Navigation Bar**: Mobile-only fixed navigation at bottom with 5 quick-access buttons
  - Dashboard, Products, Orders, Users, Settings
  - Current page highlighted in primary color
  - Icons for quick visual identification
  - Visible only on mobile (`md:hidden` on desktop)
- **Desktop Sidebar**: Always visible on left side for navigation

### Admin Dashboard Features
- **Performance Metrics**: Real-time stats (Revenue, Visitors, Orders) with time range filtering
  - Time filters: Today, 7 Days, 30 Days, Lifetime
  - Metrics include Total Revenue, Total/Unique Visitors, Order counts
- **Product Management**: Add, edit, delete products with:
  - Dynamic category-based subcategory dropdowns (Gaming only)
  - Dynamic brand selection based on product category
  - "Other" option with custom text inputs for Category/Subcategory/Brand
  - Image upload support (JPEG, PNG, HEIC via ImageMagick)
  - SEO meta description field
- **Order Management**: Track orders with status filtering
- **Audit Logging**: Track all administrative actions
- **Home Sections Management**: Configure homepage sections
- **User Management**: Manage team accounts
- **Settings**: Admin account security and preferences

### E-Commerce Features
- **Product Catalog**: Browse and filter products by category
- **Gaming Category**: Special handling with Subcategory support
- **Visitor Tracking**: Real-time analytics of unique and total visitors
- **WhatsApp Integration**: One-click order confirmation via WhatsApp
- **Responsive Design**: Mobile-optimized interface throughout