goats = [
	"http://mrclark.aretesys.com/float-goat.png",
	"http://images20.fotki.com/v106/photos/9/127099/8283206/mooat4-vi.gif"
]

module.exports = (robot) ->
  robot.hear /(fl|g)oat/i, (msg) ->
    msg.reply msg.random goats
