export function enableTableColumnTouchResize() {
  let activeTouchId: number | undefined

  function stopResizing() {
    activeTouchId = undefined
    window.dispatchEvent(new MouseEvent('mouseup'))
    window.removeEventListener('touchmove', handleTouchMove)
    window.removeEventListener('touchend', handleTouchEnd)
    window.removeEventListener('touchcancel', handleTouchEnd)
  }

  function handleTouchMove(event: TouchEvent) {
    const touch = Array.from(event.changedTouches).find((item) => item.identifier === activeTouchId)
    if (!touch) return

    event.preventDefault()
    window.dispatchEvent(new MouseEvent('mousemove', { clientX: touch.clientX, clientY: touch.clientY }))
  }

  function handleTouchEnd(event: TouchEvent) {
    if (Array.from(event.changedTouches).some((item) => item.identifier === activeTouchId)) {
      stopResizing()
    }
  }

  function handleTouchStart(event: TouchEvent) {
    if (activeTouchId !== undefined || event.touches.length !== 1 || !(event.target instanceof Element)) return

    const handle = event.target.closest('.arco-table-column-handle')
    if (!handle) return

    const touch = event.changedTouches[0]
    if (!touch) return

    event.preventDefault()
    activeTouchId = touch.identifier
    handle.dispatchEvent(new MouseEvent('mousedown', {
      bubbles: true,
      clientX: touch.clientX,
      clientY: touch.clientY
    }))
    window.addEventListener('touchmove', handleTouchMove, { passive: false })
    window.addEventListener('touchend', handleTouchEnd)
    window.addEventListener('touchcancel', handleTouchEnd)
  }

  document.addEventListener('touchstart', handleTouchStart, { passive: false })
}
