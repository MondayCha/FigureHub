<template>
  <img
    :width="width"
    :height="height"
    :srcset="srcset"
    :src="actualSrc"
    :class="{placeholder: isPlaceholderActive}"
    :style="{filter}"
  />
</template>

<script>
export default {
  // props: ['size', 'src', 'blur', 'root', 'rootMargin', 'threshold', 'placeholderImage'],
  props: {
    size: [Object, Number],
    src: String,
    blur: Number,
    root: HTMLElement,
    rootMargin: String,
    threshold: Number,
    placeholderImage: Boolean,
  },
  data() {
    return {
      srcset: null,
      actualSrc: null,
      isPlaceholderActive: false,
    }
  },
  watch: {
    size() {
      this.sourceChange()
    },
    src() {
      this.sourceChange()
    }
  },
  methods: {
    sourceChange() {
      if (this.actualSrc === null || this.srcset === null) {
        return
      }
      this.calcSrc()
    },
    calcSrc() {
      this.actualSrc = this.src
    }
  },
  mounted() {
    const options = {
      root: this.root,
      rootMargin: this.rootMargin || '200px',
      threshold: this.threshold
    }
    const observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.calcSrc()
          observer.disconnect()
        }
      })
    }, options)
    observer.observe(this.$el)
  },
  computed: {
    width() {
      if (typeof this.size === 'object' && 'width' in this.size) {
        return this.size.width
      }
      return null
    },
    height() {
      if (typeof this.size === 'object' && 'height' in this.size) {
        return this.size.height
      }
      return null
    },
    filter() {
      const filter = []
      if (this.blur) {
        filter.push(`blur(${this.blur}px)`)
      }
      // if (this.isPlaceholderActive) {
      //   filter.push(`invert(.9)`)
      // }
      return filter.join(' ')
    }
  }
}
</script>
