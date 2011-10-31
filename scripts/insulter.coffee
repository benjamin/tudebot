# Insults a user
#
# insult <username> - Insults the user

nouns = ['bat toenails', 'bug spit', 'cat hair', 'fish heads', 'gunk', 'pond scum', 'rat retch',
         'red dye number-9', 'Sun IPC manuals', 'waffle-house grits', 'yoo-hoo',
         'squirrel guts', 'snake bait', 'buzzard gizzards', 'cat-hair-balls',
         'pods', 'armadillo snouts', 'entrails', 'snake snot', 'eel ooze',
         'toxic waste', 'Stimpy-drool', 'poopy', 'poop', 'craptacular carpet droppings', 'cold sores',
         'IE user', 'chicken piss', 'dog vomit', 'dung', 'fat woman\'s stomach-bile', 'guano', 'dog balls',
         'seagull puke', 'cat bladders', 'pus', 'urine samples', 'snake assholes', 'rat-farts',
         'slurpee-backwash', 'jizzum', 'anal warts']

amounts = ['accumulation', 'bucket', 'gob', 'coagulation', 'half-mouthful', 'heap', 'mass', 'mound',
           'petrification', 'pile', 'puddle', 'stack', 'thimbleful', 'tongueful', 'ooze', 'quart',
           'bag', 'plate', 'enema-bucketful', 'ass-full', 'assload']

adjectives = ['acidic', 'antique', 'contemptible', 'culturally-unsound', 'despicable', 'evil',
              'fermented', 'festering', 'foul', 'fulminating', 'humid', 'impure', 'inept',
              'inferior', 'industrial', 'left-over', 'low-quality', 'off-color',
              'petrified', 'pointy-nosed', 'salty', 'sausage-snorfling', 'tasteless',
              'tempestuous', 'tepid', 'tofu-nibbling', 'unintelligent', 'unoriginal',
              'uninspiring', 'weasel-smelling', 'wretched', 'spam-sucking',
              'egg-sucking', 'decayed', 'halfbaked', 'infected', 'squishy', 'porous',
              'pickled', 'thick', 'vapid', 'unmuzzled', 'bawdy', 'vain', 'lumpish',
              'churlish', 'fobbing', 'craven', 'jarring', 'fly-bitten', 'fen-sucked',
              'spongy', 'droning', 'gleeking', 'warped', 'currish', 'milk-livered',
              'surly', 'mammering', 'ill-borne', 'beef-witted', 'tickle-brained',
              'half-faced', 'headless', 'wayward', 'onion-eyed', 'beslubbering',
              'villainous', 'lewd-minded', 'cockered', 'full-gorged', 'rude-snouted',
              'crook-pated', 'pribbling', 'dread-bolted', 'fool-born', 'puny',
              'fawning', 'sheep-biting', 'dankish', 'goatish', 'weather-bitten',
              'knotty-pated', 'malt-wormy', 'saucyspleened', 'motley-mind',
              'it-fowling', 'vassal-willed', 'loggerheaded', 'clapper-clawed', 'frothy',
              'ruttish', 'clouted', 'common-kissing', 'folly-fallen', 'plume-plucked',
              'flap-mouthed', 'swag-bellied', 'dizzy-eyed', 'gorbellied', 'weedy',
              'reeky', 'measled', 'spur-galled', 'mangled', 'impertinent', 'bootless',
              'toad-spotted', 'hasty-witted', 'horn-beat', 'yeasty', 'hedge-born',
              'imp-bladdereddle-headed', 'tottering', 'hugger-muggered', 'elf-skinned',
              'Microsoft-loving', 'pignutted', 'pox-marked', 'rank',
              'malodorous', 'penguin-molesting', 'coughed-up', 'hacked-up', 'rump-fed',
              'boil-brained']

module.exports = (robot) ->
  robot.respond /insult (.+)/i, (msg) ->
    username = msg.match?[1]
    msg.send "#{username}: #{build_insult msg}"

build_insult = (msg) ->
  first_adj = msg.random adjectives
  second_adj = msg.random adjectives
  noun = msg.random nouns
  amount = msg.random amounts
  prefix = "a"
  if first_adj.substr(0,1).match(/a|e|i|o|u/)
    prefix = "an"

  "You are nothing but #{prefix} #{first_adj} #{amount} of #{second_adj} #{noun}"
