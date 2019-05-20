/* 



To Set:
-------

1. Convert to ASCII
2. Zero-pad to exactly three digits
3. Repeat above for each character of the key

To Get:
-------

1. Same as Steps 1 to 3 above

 */


const indexGetter = indexInput => {
  const characters = indexInput.split('')

  const ascii = characters.map(character => {
    const raw = character.charCodeAt(0)
    return zeroPadder(raw)
  })

  return Number(ascii.join(''))
}

const zeroPadder = number => {
  if (String(number).length === 3) {
    return number
  }

  let characters = String(number).split('')

  while (characters.length < 3) {
    characters = ['0', ...characters]
  }

  return characters.join('')
}