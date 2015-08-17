class Hand < Struct.new(:letters)
  def suggestions
    suggestions_for(letters.downcase)
  end

  def suggestions_for(letters)
    self.class.all_words.select { |word| word.composable_from?(letters) }.sort
  end

  def self.all_words
    @all_words ||= begin
      File.
        readlines("/usr/share/dict/words").
        map(&:chomp).
        select { |word| word.size <= 7 && word.size > 1 }.
        map(&:downcase).
        uniq
     end
  end
end

class ::String
  def composable_from?(letters)
    characters = chars.sort
    i = 0
    letters.chars.sort.each do |letter|
      i += 1 if letter == characters[i]
    end
    i == size
  end
end

class Array
  require 'set'
  def =~(other)
    Set.new(self) == Set.new(other)
  end
end

Hand.new('go').suggestions =~ %w(go og) || raise('nope')
Hand.new('quiz').suggestions =~ %w(quiz) || raise('nope')
Hand.new('quiz').suggestions =~ %w(quiz) || raise('nope')
Hand.new('eearthuiq').suggestions =~ %w(ae aequi aer aerie ah ahet ahir aht ahu
ai air aire airt ait ar are arete arite art artie aru arui at ate ati auh
aurite aute ea ear earth eat eater eer eh eheu ehretia either equate er era ere
eria erie erth eta ether etheria etua etui eu eurite ha haet hair haire hare
hart hat hate hater hati hau he hear heart heat heater heer hei heiau heir her
herat here hereat het hi hia hiate hie hire hit hu huari hue huer hui huia hura
hure hurt hut hutia ie ira iraq irate ire it ita itea iter ither qere qeri qua
quar quare quart quat quatre queer queet quei quet quiet quieter quira quire
quirt quit quite qurti ra rah rat rate rath rathe re rea ree reet reh reheat
reit requit requite ret rethe retia retie rhe rhea rheae ria rie rit rita rite
rua rue rut ruta ruth ta tae tahr tai tar tare tareq tari tarie tau taur tauri
te tea teaer tear tee teer tera tereu teri th tha thai thar the thea thee theer
their there theria thir three ti tiar tie tier tire tra trah tree tri true tu
tua tue tui tur turi ur ura urate ure urea uri uria uriah urite ut uta utah
utai ute uteri) || raise('nope')
