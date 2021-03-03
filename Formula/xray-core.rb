class XrayCore < Formula
  desc "Xray, Penetrates Everything. Also the best xray-core, with XTLS support. Fully compatible configuration."
  homepage "https://t.me/projectXray"
  if Hardware::CPU.intel?
    url "https://github.com/XTLS/Xray-core/releases/download/v1.3.1/Xray-macos-64.zip" # intel_url
    sha256 "0f31c36d7c2b5ea49e56acae116f47796e46b29111d6678062b43eb595c7776e" # intel_sha
  else
    url "https://github.com/XTLS/Xray-core/releases/download/v1.3.1/Xray-macos-arm64-v8a.zip" # arm_url
    sha256 "0bb7c60ac3ba00b49be2aced01029587f9d925cd8f7d03d58dfac50257586da4" # arm_sha
  end
  version "1.3.1"
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
