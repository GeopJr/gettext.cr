require "./spec_helper"

# Testing is a bit limited since it depends on the host's available locales.

describe Gettext do
  it "setlocale with no parameters sets the correct default values" do
    result = Gettext.setlocale.split(/=|;/)
    (result.includes?("C.UTF-8") || result.includes?("LC_TIME")).should be_true
  end

  it "setlocale returns the new locale" do
    result = Gettext.setlocale(Gettext::LC::ALL, "en_US.utf-8")
    result.should eq("en_US.utf-8")
  end

  it "textdomain with no parameters returns the correct domain" do
    result = ["messages", "gedit"].includes?(Gettext.textdomain) # depends on test order so check both
    result.should be_true
  end

  it "textdomain returns the new domain" do
    result = Gettext.textdomain("gedit")
    result.should eq("gedit")
  end

  it "bind_textdomain_codeset returns the new codeset" do
    result = Gettext.bind_textdomain_codeset("gedit", "UTF-8")
    result.should eq("UTF-8")
  end

  # Depends on host.
  it "gettext returns the input" do
    result = Gettext.gettext("Text Editor")
    result.should eq("Text Editor")
  end

  # Depends on host.
  it "dgettext returns the input" do
    result = Gettext.dgettext("gedit", "Text Editor")
    result.should eq("Text Editor")
  end

  # Depends on host.
  it "dcgettext returns the input" do
    result = Gettext.dcgettext("gedit", "Text Editor", Gettext::LC::ALL)
    result.should eq("Text Editor")
  end

  # Depends on host.
  it "ngettext returns the single input" do
    result = Gettext.ngettext("Crystal", "Crystals", 1)
    result.should eq("Crystal")
  end

  # Depends on host.
  it "ngettext returns the plural input" do
    result = Gettext.ngettext("Crystal", "Crystals", 2)
    result.should eq("Crystals")
  end

  # Depends on host.
  it "dngettext returns the single input" do
    result = Gettext.dngettext("gedit", "Crystal", "Crystals", 1)
    result.should eq("Crystal")
  end

  # Depends on host.
  it "dngettext returns the plural input" do
    result = Gettext.dngettext("gedit", "Crystal", "Crystals", 2)
    result.should eq("Crystals")
  end

  # Depends on host.
  it "dcngettext returns the single input" do
    result = Gettext.dcngettext("gedit", "Crystal", "Crystals", 1, Gettext::LC::ALL)
    result.should eq("Crystal")
  end

  # Depends on host.
  it "dcngettext returns the plural input" do
    result = Gettext.dcngettext("gedit", "Crystal", "Crystals", 2, Gettext::LC::ALL)
    result.should eq("Crystals")
  end
end
