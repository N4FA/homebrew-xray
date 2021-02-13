class XrayCore < Formula
  desc "Xray, Penetrates Everything. Also the best xray-core, with XTLS support. Fully compatible configuration."
  homepage "https://t.me/projectXray"
  if Hardware::CPU.intel?
    url "https://github.com/XTLS/Xray-core/releases/download/v1.2.4/Xray-macos-64.zip" # intel_url
    sha256 "938c2d12734d2b0289a08e476df9fe913c806e28204c8645da727eb29e7a534e" # intel_sha
  else
    url "https://github.com/XTLS/Xray-core/releases/download/v1.2.4/Xray-macos-arm64-v8a.zip" # arm_url
    sha256 "d55ebec9e17247ea2e0e32d68a7d7f98e71886ef768fc36873f32e1960c93625" # arm_sha
  end
  version "1.2.4"
  license "MPL-2.0"


  def install
    
    bin.install "xray"
    pkgshare.install "geoip.dat"
    pkgshare.install "geosite.dat"
    (etc/"xray").mkpath


  end

  plist_options manual: "xray -config=#{HOMEBREW_PREFIX}/etc/xray/config.json"

  def plist; 

   <<~EOS
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
            <string>run</string>
            <string>-config</string>
            <string>#{etc}/xray/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
    
    
  end

  test do
  system "#{bin}/xray", "version"
  end
  
  def caveats
   <<~EOS
      Get example configs at https://github.com/XTLS/Xray-examples and save config.json to #{etc}/xray
    EOS
  end
end
