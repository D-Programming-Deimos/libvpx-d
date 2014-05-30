/*
 *  Copyright (c) 2010 The WebM project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */


/*!\file
 * \brief Describes the vpx image descriptor and associated operations
 *
 */

module libvpx.vpx.vpx_image;

extern (C) {

  /*!\brief Current ABI version number
   *
   * \internal
   * If this file is altered in any way that changes the ABI, this value
   * must be bumped.  Examples include, but are not limited to, changing
   * types, removing or reassigning enums, adding/removing/rearranging
   * fields to structures
   */
	enum VPX_IMAGE_ABI_VERSION = 2; /**<\hideinitializer*/


	enum VPX_IMG_FMT_PLANAR    = 0x100;  /**< Image is a planar format */
	enum VPX_IMG_FMT_UV_FLIP   = 0x200;  /**< V plane precedes U plane in memory */
	enum VPX_IMG_FMT_HAS_ALPHA = 0x400;  /**< Image has an alpha channel component */


  /*!\brief List of supported image formats */
	enum vpx_img_fmt {
    VPX_IMG_FMT_NONE,
    VPX_IMG_FMT_RGB24,      /**< 24 bit per pixel packed RGB */
    VPX_IMG_FMT_RGB32,      /**< 32 bit per pixel packed 0RGB */
    VPX_IMG_FMT_RGB565,     /**< 16 bit per pixel, 565 */
    VPX_IMG_FMT_RGB555,     /**< 16 bit per pixel, 555 */
    VPX_IMG_FMT_UYVY,       /**< UYVY packed YUV */
    VPX_IMG_FMT_YUY2,       /**< YUYV packed YUV */
    VPX_IMG_FMT_YVYU,       /**< YVYU packed YUV */
    VPX_IMG_FMT_BGR24,      /**< 24 bit per pixel packed BGR */
    VPX_IMG_FMT_RGB32_LE,   /**< 32 bit packed BGR0 */
    VPX_IMG_FMT_ARGB,       /**< 32 bit packed ARGB, alpha=255 */
    VPX_IMG_FMT_ARGB_LE,    /**< 32 bit packed BGRA, alpha=255 */
    VPX_IMG_FMT_RGB565_LE,  /**< 16 bit per pixel, gggbbbbb rrrrrggg */
    VPX_IMG_FMT_RGB555_LE,  /**< 16 bit per pixel, gggbbbbb 0rrrrrgg */
    VPX_IMG_FMT_YV12    = VPX_IMG_FMT_PLANAR | VPX_IMG_FMT_UV_FLIP | 1, /**< planar YVU */
    VPX_IMG_FMT_I420    = VPX_IMG_FMT_PLANAR | 2,
    VPX_IMG_FMT_VPXYV12 = VPX_IMG_FMT_PLANAR | VPX_IMG_FMT_UV_FLIP | 3, /** < planar 4:2:0 format with vpx color space */
    VPX_IMG_FMT_VPXI420 = VPX_IMG_FMT_PLANAR | 4,
    VPX_IMG_FMT_I422    = VPX_IMG_FMT_PLANAR | 5,
    VPX_IMG_FMT_I444    = VPX_IMG_FMT_PLANAR | 6,
    VPX_IMG_FMT_444A    = VPX_IMG_FMT_PLANAR | VPX_IMG_FMT_HAS_ALPHA | 7
  }
	alias vpx_img_fmt_t = vpx_img_fmt; /**< alias for enum vpx_img_fmt */

	enum IMG_FMT_PLANAR        = VPX_IMG_FMT_PLANAR;     /**< \deprecated Use #VPX_IMG_FMT_PLANAR */
	enum IMG_FMT_UV_FLIP       = VPX_IMG_FMT_UV_FLIP;    /**< \deprecated Use #VPX_IMG_FMT_UV_FLIP */
	enum IMG_FMT_HAS_ALPHA     = VPX_IMG_FMT_HAS_ALPHA;  /**< \deprecated Use #VPX_IMG_FMT_HAS_ALPHA */

  /*!\brief Deprecated list of supported image formats
   * \deprecated New code should use #vpx_img_fmt
   */
	alias img_fmt = vpx_img_fmt;
  /*!\brief alias for enum img_fmt.
   * \deprecated New code should use #vpx_img_fmt_t
   */
	alias img_fmt_t = vpx_img_fmt_t;

	enum IMG_FMT_NONE      = vpx_img_fmt.VPX_IMG_FMT_NONE;       /**< \deprecated Use #VPX_IMG_FMT_NONE */
	enum IMG_FMT_RGB24     = vpx_img_fmt.VPX_IMG_FMT_RGB24;      /**< \deprecated Use #VPX_IMG_FMT_RGB24 */
	enum IMG_FMT_RGB32     = vpx_img_fmt.VPX_IMG_FMT_RGB32;      /**< \deprecated Use #VPX_IMG_FMT_RGB32 */
	enum IMG_FMT_RGB565    = vpx_img_fmt.VPX_IMG_FMT_RGB565;     /**< \deprecated Use #VPX_IMG_FMT_RGB565 */
	enum IMG_FMT_RGB555    = vpx_img_fmt.VPX_IMG_FMT_RGB555;     /**< \deprecated Use #VPX_IMG_FMT_RGB555 */
	enum IMG_FMT_UYVY      = vpx_img_fmt.VPX_IMG_FMT_UYVY;       /**< \deprecated Use #VPX_IMG_FMT_UYVY */
	enum IMG_FMT_YUY2      = vpx_img_fmt.VPX_IMG_FMT_YUY2;       /**< \deprecated Use #VPX_IMG_FMT_YUY2 */
	enum IMG_FMT_YVYU      = vpx_img_fmt.VPX_IMG_FMT_YVYU;       /**< \deprecated Use #VPX_IMG_FMT_YVYU */
	enum IMG_FMT_BGR24     = vpx_img_fmt.VPX_IMG_FMT_BGR24;      /**< \deprecated Use #VPX_IMG_FMT_BGR24 */
	enum IMG_FMT_RGB32_LE  = vpx_img_fmt.VPX_IMG_FMT_RGB32_LE;   /**< \deprecated Use #VPX_IMG_FMT_RGB32_LE */
	enum IMG_FMT_ARGB      = vpx_img_fmt.VPX_IMG_FMT_ARGB;       /**< \deprecated Use #VPX_IMG_FMT_ARGB */
	enum IMG_FMT_ARGB_LE   = vpx_img_fmt.VPX_IMG_FMT_ARGB_LE;    /**< \deprecated Use #VPX_IMG_FMT_ARGB_LE */
	enum IMG_FMT_RGB565_LE = vpx_img_fmt.VPX_IMG_FMT_RGB565_LE;  /**< \deprecated Use #VPX_IMG_FMT_RGB565_LE */
	enum IMG_FMT_RGB555_LE = vpx_img_fmt.VPX_IMG_FMT_RGB555_LE;  /**< \deprecated Use #VPX_IMG_FMT_RGB555_LE */
	enum IMG_FMT_YV12      = vpx_img_fmt.VPX_IMG_FMT_YV12;       /**< \deprecated Use #VPX_IMG_FMT_YV12 */
	enum IMG_FMT_I420      = vpx_img_fmt.VPX_IMG_FMT_I420;       /**< \deprecated Use #VPX_IMG_FMT_I420 */
	enum IMG_FMT_VPXYV12   = vpx_img_fmt.VPX_IMG_FMT_VPXYV12;    /**< \deprecated Use #VPX_IMG_FMT_VPXYV12 */
	enum IMG_FMT_VPXI420   = vpx_img_fmt.VPX_IMG_FMT_VPXI420;    /**< \deprecated Use #VPX_IMG_FMT_VPXI420 */

  /**\brief Image Descriptor */
	struct vpx_image {
    vpx_img_fmt_t fmt; /**< Image Format */

    /* Image storage dimensions */
    uint  w;   /**< Stored image width */
    uint  h;   /**< Stored image height */

    /* Image display dimensions */
    uint  d_w;   /**< Displayed image width */
    uint  d_h;   /**< Displayed image height */

    /* Chroma subsampling info */
    uint  x_chroma_shift;   /**< subsampling order, X */
    uint  y_chroma_shift;   /**< subsampling order, Y */

    /* Image data pointers. */
		private enum VPX_PLANE_PACKED = 0;   /**< To be used for all packed formats */
		private enum VPX_PLANE_Y      = 0;   /**< Y (Luminance) plane */
		private enum VPX_PLANE_U      = 1;   /**< U (Chroma) plane */
		private enum VPX_PLANE_V      = 2;   /**< V (Chroma) plane */
		private enum VPX_PLANE_ALPHA  = 3;   /**< A (Transparency) plane */
		private enum PLANE_PACKED     = VPX_PLANE_PACKED;
		private enum PLANE_Y          = VPX_PLANE_Y;
		private enum PLANE_U          = VPX_PLANE_U;
		private enum PLANE_V          = VPX_PLANE_V;
		private enum PLANE_ALPHA      = VPX_PLANE_ALPHA;

    ubyte  *planes[4];  /**< pointer to the top left pixel for each plane */
    int     stride[4];  /**< stride between rows for each plane */

    int     bps; /**< bits per sample (for packed formats) */

    /* The following member may be set by the application to associate data
     * with this image.
     */
    void   *user_priv; /**< may be set by the application to associate data
                         *   with this image. */

    /* The following members should be treated as private. */
    ubyte *img_data;       /**< private */
    int    img_data_owner; /**< private */
    int    self_allocd;    /**< private */

    void  *fb_priv; /**< Frame buffer data associated with the image. */
  }
	alias vpx_image_t = vpx_image; /**< alias for struct vpx_image */

  /**\brief Representation of a rectangle on a surface */
	struct vpx_image_rect {
    uint x; /**< leftmost column */
    uint y; /**< topmost row */
    uint w; /**< width */
    uint h; /**< height */
  }
	alias vpx_image_rect_t = vpx_image_rect; /**< alias for struct vpx_image_rect */

  /*!\brief Open a descriptor, allocating storage for the underlying image
   *
   * Returns a descriptor for storing an image of the given format. The
   * storage for the descriptor is allocated on the heap.
   *
   * \param[in]    img       Pointer to storage for descriptor. If this parameter
   *                         is NULL, the storage for the descriptor will be
   *                         allocated on the heap.
   * \param[in]    fmt       Format for the image
   * \param[in]    d_w       Width of the image
   * \param[in]    d_h       Height of the image
   * \param[in]    align     Alignment, in bytes, of the image buffer and
   *                         each row in the image(stride).
   *
   * \return Returns a pointer to the initialized image descriptor. If the img
   *         parameter is non-null, the value of the img parameter will be
   *         returned.
   */
  vpx_image_t *vpx_img_alloc(vpx_image_t  *img,
                             vpx_img_fmt_t fmt,
                             uint d_w,
                             uint d_h,
                             uint alignment);

  /*!\brief Open a descriptor, using existing storage for the underlying image
   *
   * Returns a descriptor for storing an image of the given format. The
   * storage for descriptor has been allocated elsewhere, and a descriptor is
   * desired to "wrap" that storage.
   *
   * \param[in]    img       Pointer to storage for descriptor. If this parameter
   *                         is NULL, the storage for the descriptor will be
   *                         allocated on the heap.
   * \param[in]    fmt       Format for the image
   * \param[in]    d_w       Width of the image
   * \param[in]    d_h       Height of the image
   * \param[in]    alignment     Alignmentment, in bytes, of each row in the image.
   * \param[in]    img_data  Storage to use for the image
   *
   * \return Returns a pointer to the initialized image descriptor. If the img
   *         parameter is non-null, the value of the img parameter will be
   *         returned.
   */
  vpx_image_t *vpx_img_wrap(vpx_image_t  *img,
                            vpx_img_fmt_t fmt,
                            uint d_w,
                            uint d_h,
                            uint alignment,
                            ubyte *img_data);


  /*!\brief Set the rectangle identifying the displayed portion of the image
   *
   * Updates the displayed rectangle (aka viewport) on the image surface to
   * match the specified coordinates and size.
   *
   * \param[in]    img       Image descriptor
   * \param[in]    x         leftmost column
   * \param[in]    y         topmost row
   * \param[in]    w         width
   * \param[in]    h         height
   *
   * \return 0 if the requested rectangle is valid, nonzero otherwise.
   */
  int vpx_img_set_rect(vpx_image_t  *img,
                       uint  x,
                       uint  y,
                       uint  w,
                       uint  h);


  /*!\brief Flip the image vertically (top for bottom)
   *
   * Adjusts the image descriptor's pointers and strides to make the image
   * be referenced upside-down.
   *
   * \param[in]    img       Image descriptor
   */
  void vpx_img_flip(vpx_image_t *img);

  /*!\brief Close an image descriptor
   *
   * Frees all allocated storage associated with an image descriptor.
   *
   * \param[in]    img       Image descriptor
   */
  void vpx_img_free(vpx_image_t *img);

}  // extern "C"
