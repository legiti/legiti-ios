#
#  Be sure to run `pod spec lint InspetorSwiftFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "InspetorSwiftFramework"
  spec.version      = "0.2.0"
  spec.summary      = "Inspetor antifraud monitoring for iOS."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
Swift framework for incorporating Inspetor antifraud monitoring into iOS apps.
                   DESC

  spec.homepage     = "https://github.com/inspetor"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => "EULA", :text => <<-LICENSE
    End-User License Agreement (EULA) of Inspetor
    This End-User License Agreement ("EULA") is a legal agreement between you and Inspetor

    This EULA agreement governs your acquisition and use of our Inspetor software ("Software") directly from Inspetor or indirectly through a Inspetor authorized reseller or distributor (a "Reseller").

    Please read this EULA agreement carefully before completing the installation process and using the Inspetor software. It provides a license to use the Inspetor software and contains warranty information and liability disclaimers.

    If you register for a free trial of the Inspetor software, this EULA agreement will also govern that trial. By clicking "accept" or installing and/or using the Inspetor software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.

    If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.

    This EULA agreement shall apply only to the Software supplied by Inspetor herewith regardless of whether other software is referred to or described herein. The terms also apply to any Inspetor updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for Inspetor.

    License Grant
    Inspetor hereby grants you a personal, non-transferable, non-exclusive licence to use the Inspetor software on your devices in accordance with the terms of this EULA agreement.

    You are permitted to load the Inspetor software (for example a PC, laptop, mobile or tablet) under your control. You are responsible for ensuring your device meets the minimum requirements of the Inspetor software.

    You are not permitted to:

    Edit, alter, modify, adapt, translate or otherwise change the whole or any part of the Software nor permit the whole or any part of the Software to be combined with or become incorporated in any other software, nor decompile, disassemble or reverse engineer the Software or attempt to do any such things
    Reproduce, copy, distribute, resell or otherwise use the Software for any commercial purpose
    Allow any third party to use the Software on behalf of or for the benefit of any third party
    Use the Software in any way which breaches any applicable local, national or international law
    use the Software for any purpose that Inspetor considers is a breach of this EULA agreement
    Intellectual Property and Ownership
    Inspetor shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Inspetor.

    Inspetor reserves the right to grant licences to use the Software to third parties.

    Termination
    This EULA agreement is effective from the date you first use the Software and shall continue until terminated. You may terminate it at any time upon written notice to Inspetor.

    It will also terminate immediately if you fail to comply with any term of this EULA agreement. Upon such termination, the licenses granted by this EULA agreement will immediately terminate and you agree to stop all access and use of the Software. The provisions that by their nature continue and survive will survive any termination of this EULA agreement.

    Governing Law
    This EULA agreement, and any dispute arising out of or in connection with this EULA agreement, shall be governed by and construed in accordance with the laws of br.
  LICENSE
 }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Pearson Henri" => "pearson@useinspetor.com" }
  # Or just: spec.author    = "Pearson Henri"
  # spec.authors            = { "Pearson Henri" => "email@address.com" }
  # spec.social_media_url   = "https://twitter.com/Pearson Henri"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "11.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/inspetor/inspetor-swift-framework-dist.git", :tag => "0.1.0" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "InspetorSwiftFramework.framework/Headers/*.h"
  spec.public_header_files = "InspetorSwiftFramework.framework/Headers/*.h"
  spec.vendored_frameworks = "InspetorSwiftFramework.framework"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency "SnowplowTracker", "~> 1.0"

  spec.swift_version = "4.2"

end
