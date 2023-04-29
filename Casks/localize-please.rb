cask "localize-please" do
  version "1.0.0"
  sha256 "435628505fc49e4de40d27a2f4557a8eb1e1e57203545ca714d7c2d4d562d8ce"

  url "https://github.com/soulverteam/localize-please/releases/download/#{version}/localize-please.zip"
  name "localize-please"
  desc "A command-line tool that uses ChatGPT to automatically localize your Xcode localization files (.xloc) or .strings files"
  homepage "https://github.com/soulverteam/localize-please"

  depends_on macos: ">= :ventura"
  
  binary "localize-please"

  zap trash: [
    "~/Library/Preferences/localize-please.plist",
  ]
end