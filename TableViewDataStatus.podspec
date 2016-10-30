Pod::Spec.new do |s|

  s.name         = "TableViewDataStatus"
  s.version      = "2.0.0"
  s.summary      = "Table View to control Data Status. Allows to add loading and empty views. Automatically controls the visibility of the views."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GabrielMassana/TableViewDataStatus-iOS.git", :tag => s.version, :branch => "master"}
  
  s.source_files  = "TableViewDataStatus-iOS/**/*.swift"

  s.requires_arc = true

end

