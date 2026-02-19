// =========================================================================
// CAS Identities Compatibility Shim
// =========================================================================
// Backward-compatible module path. Canonical identities data lives in:
//   src/truths/identities.typ
// Rewrite engine lives in:
//   src/identity-engine.typ
// =========================================================================

#import "truths/identities.typ": identity-rules
#import "identity-engine.typ": wild, apply-identities-once

