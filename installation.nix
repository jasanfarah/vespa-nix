{ lib
, stdenv
, fetchurl
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "vespa-cli";
  version = "8.416.42";

  src = fetchurl {
    url = "https://github.com/vespa-engine/vespa/releases/download/v${version}/vespa-cli_${version}_linux_amd64.tar.gz";
    sha256 = "d60cadc9e49b843818e6759d9b94d87aa7947f1543e622ce5dc28a73d032e5b6";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  unpackPhase = ''
    mkdir -p $out
    tar xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share
    mv vespa-cli_${version}_linux_amd64/bin/vespa $out/bin/
    mv vespa-cli_${version}_linux_amd64/share/man $out/share/
    mv vespa-cli_${version}_linux_amd64/LICENSE $out/
    chmod +x $out/bin/vespa
  '';

  meta = with lib; {
    description = "Command-line tool for Vespa.ai";
    homepage = "https://vespa.ai";
    changelog = "https://github.com/vespa-engine/vespa/releases/tag/v${version}";
    license = licenses.asl20;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [jasanfarah];
    mainProgram = "vespa";
  };
}
