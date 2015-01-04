Pod::Spec.new do |s|
  s.name         = "Recorder"
  s.version      = "0.0.1"
  s.summary      = "Record and export a view hierarchy to PNG or JPEG frames for flip book style animations (as used in WatchKit)."

  s.description  = <<-DESC
                   Record and export a view hierarchy to PNG or JPEG frames for flip book style animations (as used in WatchKit).
		   Example usage: output a UIView animation to PNG or JPG and then play it on the Apple Watch. 
		DESC

  s.homepage     = "https://github.com/andydrizen/UIViewRecorder"
  s.license      = "MIT"
  s.author             = { "Andy Drizen" => "andydrizen@gmail.com" }
  s.social_media_url   = "http://twitter.com/andydrizen"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/andydrizen/UIViewRecorder.git", :tag => "0.0.1" }
  s.source_files  = "Recorder.swift"
end
