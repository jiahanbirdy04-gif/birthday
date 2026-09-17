# Birthday Bloom

A GitHub Pages-ready birthday PWA with Supabase-backed media storage.

## Files

Upload all files in this folder to a GitHub repository. Enable GitHub Pages from the repository's Pages settings. Open the HTTPS Pages URL on a phone and use the browser's **Add to Home Screen** option.

## Supabase setup

Run the complete [`supabase-setup.sql`](supabase-setup.sql) file in **Supabase Dashboard → SQL Editor → New query → Run**. It creates the `birthday_sites` table, enables RLS, adds the required select/insert/update policies for the app's `upsert`, creates the `birthday-media` bucket, and adds storage read/upload/update policies.

The URL and publishable key are already in `index.html`. Replace them if you use a different Supabase project. For a private or multi-user app, use authenticated users and stricter RLS instead of the simple public policies above. Never put a Supabase service-role key in this HTML file.

## Editor

Tap the pencil button. Add a recipient name, memorable site key, photos, an editable short background/story for each photo, Happy Birthday audio, and the final letter. Photos preserve their natural landscape or portrait proportions in the swipeable gallery. Use **Preview changes** to save locally and **Download GitHub file** to create a self-contained shareable HTML copy.

## Notes

Use HTTPS for GitHub Pages so the service worker and install prompt work. Mobile browsers require a user gesture before audio can play; the candle tap is the gesture used to start the Happy Birthday clip. The current version intentionally removes the Flowers and Soundtrack sections while the home, Memories, Notes, and Finale flow is refined.
