const init = () => {


    const toggleFullscreen = () => {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen();
        } else {
            document.exitFullscreen();
        }
    }

    const exitFullScreen = () => {
        document.exitFullscreen();
    }

    const enterFullScreen = () => {
        document.documentElement.requestFullscreen();
    }

    window._requestFullscreen = enterFullScreen;
    window._exitFullscreen = exitFullScreen;
    window._toggleFullscreen = toggleFullscreen;
}

window.onload = () => {
    init();
}