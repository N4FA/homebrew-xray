class XrayCore < Formula
  desc "Xray, Penetrates Everything. Also the best xray-core, with XTLS support. Fully compatible configuration."
  homepage "https://t.me/projectXray"
  if Hardware::CPU.intel?
    url "https://github.com/XTLS/Xray-core/releases/download/v1.4.0/Xray-macos-64.zip" # intel_url
    sha256 "59cd13f719162a558e2cd90292977f014089a09bcccc02459568e23c8ff31a6d" # intel_sha
  else
    url "https://github.com/XTLS/Xray-core/releases/download/v1.4.0/Xray-macos-arm64-v8a.zip" # arm_url
    sha256 "2132f9c6b9f66c2a1b7a92dd98ba54222ad77f5a73eda038a532bd808aa142dc" # arm_sha
  end
  version "1.4.0"
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
