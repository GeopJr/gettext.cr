lib LibC
  fun setlocale(category : Int, locale : Char*) : Char*
  fun gettext(msgid : Char*) : Char*
  fun dgettext(domainname : Char*, msgid : Char*) : Char*
  fun dcgettext(domainname : Char*, msgid : Char*, category : Int) : Char*
  fun ngettext(msgid1 : Char*, msgid2 : Char*, n : ULong) : Char*
  fun dngettext(domainname : Char*, msgid1 : Char*, msgid2 : Char*, n : ULong) : Char*
  fun dcngettext(domainname : Char*, msgid1 : Char*, msgid2 : Char*, n : ULong, category : Int) : Char*
  fun textdomain(domainname : Char*) : Char*
  fun bindtextdomain(domainname : Char*, dirname : Char*) : Char*
  fun bind_textdomain_codeset(domainname : Char*, codeset : Char*) : Char*
end

# Bindings for the GNU & Musl gettext library.
#
# NOTE: Documentation is meant to be viewed alongside the C one.
# WARNING: It goes without saying that both the locales and the text domains you input need to be available for the bindings to work.
module Gettext
  extend self

  # All locale environment variables.
  enum LC
    CTYPE
    NUMERIC
    TIME
    COLLATE
    MONETARY
    MESSAGES
    ALL
    PAPER
    NAME
    ADDRESS
    TELEPHONE
    MEASUREMENT
    IDENTIFICATION
  end

  # Sets the current locale, overriding the one set by the env var / category.
  # If no parameters are provided, it sets LC:ALL to "".
  #
  # Returns the new locale or all categories.
  #
  # Example:
  # ```
  # Gettext.setlocale(Gettext::LC::ALL, "el_GR.UTF-8") # => "el_GR.UTF-8"
  # ```
  def setlocale(category : LC = LC::ALL, locale : String = "") : String
    String.new(LibC.setlocale(category, locale))
  end

  # Returns the translated msgid from the current text domain.
  #
  # Example:
  # ```
  # Gettext.setlocale(Gettext::LC::ALL, "el_GR.UTF-8")
  # Gettext.textdomain("gedit")
  # Gettext.gettext("Text Editor") # => "Επεξεργαστής κειμένου"
  # ```
  def gettext(msgid : String) : String
    String.new(LibC.gettext(msgid))
  end

  # Returns the translated msgid from the desired text domain.
  #
  # Example:
  # ```
  # Gettext.setlocale(Gettext::LC::ALL, "el_GR.UTF-8")
  # Gettext.dgettext("gedit", "Text Editor") # => "Επεξεργαστής κειμένου"
  # ```
  def dgettext(domainname : String, msgid : String) : String
    String.new(LibC.dgettext(domainname, msgid))
  end

  # Returns the translated msgid from the desired text domain and category.
  #
  # Example:
  # ```
  # Gettext.setlocale(Gettext::LC::ALL, "el_GR.UTF-8")
  # Gettext.dcgettext("gedit", "Text Editor", Gettext::LC::ALL) # => "Επεξεργαστής κειμένου"
  # ```
  def dcgettext(domainname : String, msgid : String, category : LC) : String
    String.new(LibC.dcgettext(domainname, msgid, category))
  end

  # Same as `gettext` but supports plural forms.
  #
  # Example:
  # ```
  # Gettext.ngettext("Crystal", "Crystals", 2) # => "Crystals"
  # ```
  def ngettext(msgid1 : String, msgid2 : String, n : UInt32) : String
    String.new(LibC.ngettext(msgid1, msgid2, n))
  end

  # Same as `dgettext` but supports plural forms.
  #
  # Example:
  # ```
  # Gettext.dngettext("gedit", "Crystal", "Crystals", 2) # => "Crystals"
  # ```
  def dngettext(domainname : String, msgid1 : String, msgid2 : String, n : UInt32) : String
    String.new(LibC.dngettext(domainname, msgid1, msgid2, n))
  end

  # Same as `dcgettext` but supports plural forms.
  #
  # Example:
  # ```
  # Gettext.dcngettext("gedit", "Crystal", "Crystals", 2, Gettext::LC::ALL) # => "Crystals"
  # ```
  def dcngettext(domainname : String, msgid1 : String, msgid2 : String, n : UInt32, category : LC) : String
    String.new(LibC.dcngettext(domainname, msgid1, msgid2, n, category))
  end

  # Sets the current text domain to one that is already available.
  # If no parameters are provided, it returns the current one.
  #
  # Returns the new (or current) text domain.
  #
  # Example:
  # ```
  # Gettext.textdomain("gedit") # => "gedit"
  # Gettext.textdomain          # => "gedit"
  # ```
  def textdomain(domainname : String | Nil = nil) : String
    String.new(LibC.textdomain(domainname))
  end

  # Sets the current text domain to a local one.
  #
  # Returns the new text domain.
  #
  # Example:
  # ```
  # Gettext.bindtextdomain("my-domain", ".")              # => "."
  # Gettext.bindtextdomain("my-domain", Path[ENV["PWD"]]) # => "(pwd)"
  # ```
  def bindtextdomain(domainname : String, dirname : String | Path) : String
    String.new(LibC.bindtextdomain(domainname, "#{dirname}"))
  end

  # Sets the current text domain's codeset.
  # If no parameters are provided, it sets it to UTF-8.
  #
  # Returns the new codeset.
  #
  # Example:
  # ```
  # Gettext.bind_textdomain_codeset("my-domain", "UTF-8") # => "UTF-8"
  # ```
  def bind_textdomain_codeset(domainname : String, codeset : String = "UTF-8") : String
    String.new(LibC.bind_textdomain_codeset(domainname, codeset))
  end
end
