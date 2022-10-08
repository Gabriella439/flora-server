{ mkDerivation, aeson, base, bytestring, effectful-core, fetchgit
, lib, log-base, text, time
}:
mkDerivation {
  pname = "log-effectful";
  version = "1.0.0.0";
  src = fetchgit {
    url = "https://github.com/haskell-effectful/log-effectful.git";
    sha256 = "08sj70nhk6nl8gbbgppak8f6y8k2wdi6il2vvyp1ll7m22sd0ij8";
    rev = "8f4658052434e5ba6f3f729e8b8588aeef65938e";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    aeson base bytestring effectful-core log-base text time
  ];
  testHaskellDepends = [ aeson base effectful-core log-base text ];
  description = "Adaptation of the log library for the effectful ecosystem";
  license = lib.licenses.bsd3;
}
