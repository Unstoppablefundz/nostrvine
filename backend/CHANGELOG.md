# Changelog

All notable changes to the OpenVine Backend will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New `/api/import-url` endpoint for importing videos from external URLs
  - Supports fetching videos from any HTTP/HTTPS URL including Google Cloud Storage
  - Optional Cloudinary integration for content moderation and thumbnail generation
  - Automatic deduplication based on SHA256 hash
  - NIP-98 authentication required
  - Returns NIP-94 event data compatible with existing upload flow

### Changed
- Video dimensions now correctly set to 640x640 for square Vine format
- Thumbnail generation creates square thumbnails (320x320, 640x640, 1280x1280)

### Technical Details
- Added `url-import.ts` handler with support for:
  - Direct R2 storage mode (default)
  - Cloudinary processing mode with content moderation
  - Lazy thumbnail generation for R2 uploads
  - Eager thumbnail transformations for Cloudinary uploads