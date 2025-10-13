// ABOUTME: Helper functions for publishing ProofMode data to Nostr events
// ABOUTME: Extracts verification levels and creates Nostr tags from ProofManifest

import 'dart:convert';
import 'package:openvine/services/proofmode_session_service.dart';

/// Extract proof-verification-level from ProofManifest
///
/// Returns one of:
/// - 'verified_mobile': has attestation + manifest + signature
/// - 'verified_web': has manifest + signature (no hardware attestation)
/// - 'basic_proof': has some proof data but no signature
/// - 'unverified': no meaningful proof data
String getVerificationLevel(ProofManifest manifest) {
  // verified_mobile: has attestation + manifest + signature
  if (manifest.deviceAttestation != null && manifest.pgpSignature != null) {
    return 'verified_mobile';
  }

  // verified_web: has manifest + signature (no hardware attestation)
  if (manifest.pgpSignature != null) {
    return 'verified_web';
  }

  // basic_proof: has some proof data
  if (manifest.segments.isNotEmpty) {
    return 'basic_proof';
  }

  return 'unverified';
}

/// Create proof-manifest tag value (compact JSON)
///
/// Serializes the entire ProofManifest to JSON for inclusion in Nostr events
String createProofManifestTag(ProofManifest manifest) {
  return jsonEncode(manifest.toJson());
}

/// Create proof-device-attestation tag value
///
/// Returns the device attestation token if available, null otherwise
String? createDeviceAttestationTag(ProofManifest manifest) {
  return manifest.deviceAttestation?.token;
}

/// Create proof-pgp-fingerprint tag value
///
/// Returns the PGP public key fingerprint if signature is available, null otherwise
String? createPgpFingerprintTag(ProofManifest manifest) {
  return manifest.pgpSignature?.publicKeyFingerprint;
}
