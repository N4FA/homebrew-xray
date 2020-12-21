class XrayCore < Formula
  desc "Xray, Penetrates Everything. Also the best xray-core, with XTLS support. Fully compatible configuration."
  homepage "https://t.me/projectXray"
  url "https://github.com/XTLS/Xray-core/releases/download/v1.1.4/Xray-macos-64.zip"
  sha256 "9e12f4b7a18d124ce118167761152e31aca4e51dccc509a7858b780c468c8b37"
  license "MPL-2.0"


  def install
    bin.install "xray"
    pkgshare.install "geoip.dat"
    pkgshare.install "geosite.dat"

  end

  plist_options manual: "xray -config=#{HOMEBREW_PREFIX}/etc/xray/config.json"

  def plist; <<~EOS
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>RunAtLoad</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/xray</string>
      </array>
    </dict>
  </plist>
  EOS
  end

  test do

  end
  
  def caveats
    <<~EOS
    EOS
  end
end
