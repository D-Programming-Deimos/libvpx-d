/*
 *  Copyright (c) 2010 The WebM project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */


/*!\defgroup codec Common Algorithm Interface
 * This abstraction allows applications to easily support multiple video
 * formats with minimal code duplication. This section describes the interface
 * common to all codecs (both encoders and decoders).
 * @{
 */

/*!\file
 * \brief Describes the codec algorithm interface to applications.
 *
 * This file describes the interface between an application and a
 * video codec algorithm.
 *
 * An application instantiates a specific codec instance by using
 * vpx_codec_init() and a pointer to the algorithm's interface structure:
 *     <pre>
 *     my_app.c:
 *       extern vpx_codec_iface_t my_codec;
 *       {
 *           vpx_codec_ctx_t algo;
 *           res = vpx_codec_init(&algo, &my_codec);
 *       }
 *     </pre>
 *
 * Once initialized, the instance is manged using other functions from
 * the vpx_codec_* family.
 */

module libvpx.vpx.vpx_codec;

extern (C) {

	import libvpx.vpx.vpx_integer;
	import libvpx.vpx.vpx_image;

	enum VPX_CODEC_ABI_VERSION = (2 + VPX_IMAGE_ABI_VERSION);

  /*!\brief Algorithm return codes */
	enum vpx_codec_err_t {
    /*!\brief Operation completed without error */
    VPX_CODEC_OK,

    /*!\brief Unspecified error */
    VPX_CODEC_ERROR,

    /*!\brief Memory operation failed */
    VPX_CODEC_MEM_ERROR,

    /*!\brief ABI version mismatch */
    VPX_CODEC_ABI_MISMATCH,

    /*!\brief Algorithm does not have required capability */
    VPX_CODEC_INCAPABLE,

    /*!\brief The given bitstream is not supported.
     *
     * The bitstream was unable to be parsed at the highest level. The decoder
     * is unable to proceed. This error \ref SHOULD be treated as fatal to the
     * stream. */
    VPX_CODEC_UNSUP_BITSTREAM,

    /*!\brief Encoded bitstream uses an unsupported feature
     *
     * The decoder does not implement a feature required by the encoder. This
     * return code should only be used for features that prevent future
     * pictures from being properly decoded. This error \ref MAY be treated as
     * fatal to the stream or \ref MAY be treated as fatal to the current GOP.
     */
    VPX_CODEC_UNSUP_FEATURE,

    /*!\brief The coded data for this stream is corrupt or incomplete
     *
     * There was a problem decoding the current frame.  This return code
     * should only be used for failures that prevent future pictures from
     * being properly decoded. This error \ref MAY be treated as fatal to the
     * stream or \ref MAY be treated as fatal to the current GOP. If decoding
     * is continued for the current GOP, artifacts may be present.
     */
    VPX_CODEC_CORRUPT_FRAME,

    /*!\brief An application-supplied parameter is not valid.
     *
     */
    VPX_CODEC_INVALID_PARAM,

    /*!\brief An iterator reached the end of list.
     *
     */
    VPX_CODEC_LIST_END
  }

  /*! \brief Initialization-time Feature Enabling
   *
   *  Certain codec features must be known at initialization time, to allow for
   *  proper memory allocation.
   *
   *  The available flags are specified by VPX_CODEC_USE_* defines.
   */
	alias vpx_codec_flags_t = long;

  /*!\brief Codec interface structure.
   *
   * Contains function pointers and other data private to the codec
   * implementation. This structure is opaque to the application.
   */
	struct vpx_codec_iface; // TODO: is this code safe ?
	alias vpx_codec_iface_t = vpx_codec_iface;


  /*!\brief Codec private data structure.
   *
   * Contains data private to the codec implementation. This structure is opaque
   * to the application.
   */
	struct vpx_codec_priv;
	alias vpx_codec_priv_t = vpx_codec_priv;


  /*!\brief Iterator
   *
   * Opaque storage used for iterating over lists.
   */
	alias vpx_codec_iter_t = const void *;

	struct vpx_codec_dec_cfg;
	struct vpx_codec_enc_cfg;
  /*!\brief Codec context structure
   *
   * All codecs \ref MUST support this context structure fully. In general,
   * this data should be considered private to the codec algorithm, and
   * not be manipulated or examined by the calling application. Applications
   * may reference the 'name' member to get a printable description of the
   * algorithm.
   */
	struct vpx_codec_ctx {
    const char             *name;        /**< Printable interface name */
    vpx_codec_iface_t      *iface;       /**< Interface pointers */
    vpx_codec_err_t         err;         /**< Last returned error */
    const char             *err_detail;  /**< Detailed info, if available */
    vpx_codec_flags_t       init_flags;  /**< Flags passed at init time */

    private union vpx_codec_ctx_cfg {
      vpx_codec_dec_cfg    *dec;        /**< Decoder Configuration Pointer */
      vpx_codec_enc_cfg    *enc;        /**< Encoder Configuration Pointer */
      void                 *raw;
    }
		vpx_codec_ctx_cfg      config;      /**< Configuration pointer aliasing union */
    vpx_codec_priv_t      *priv;        /**< Algorithm private storage */
  }
	alias vpx_codec_ctx_t = vpx_codec_ctx;


  /*
   * Library Version Number Interface
   *
   * For example, see the following sample return values:
   *     vpx_codec_version()           (1<<16 | 2<<8 | 3)
   *     vpx_codec_version_str()       "v1.2.3-rc1-16-gec6a1ba"
   *     vpx_codec_version_extra_str() "rc1-16-gec6a1ba"
   */

  /*!\brief Return the version information (as an integer)
   *
   * Returns a packed encoding of the library version number. This will only include
   * the major.minor.patch component of the version number. Note that this encoded
   * value should be accessed through the macros provided, as the encoding may change
   * in the future.
   *
   */
  int vpx_codec_version();

  /*!\brief Return the version information (as a string)
   *
   * Returns a printable string containing the full library version number. This may
   * contain additional text following the three digit version number, as to indicate
   * release candidates, prerelease versions, etc.
   *
   */
  const char *vpx_codec_version_str();


  /*!\brief Return the version information (as a string)
   *
   * Returns a printable "extra string". This is the component of the string returned
   * by vpx_codec_version_str() following the three digit version number.
   *
   */
  const char *vpx_codec_version_extra_str();


  /*!\brief Return the build configuration
   *
   * Returns a printable string containing an encoded version of the build
   * configuration. This may be useful to vpx support.
   *
   */
  const char *vpx_codec_build_config();


  /*!\brief Return the name for a given interface
   *
   * Returns a human readable string for name of the given codec interface.
   *
   * \param[in]    iface     Interface pointer
   *
   */
  const char *vpx_codec_iface_name(vpx_codec_iface_t *iface);


  /*!\brief Convert error number to printable string
   *
   * Returns a human readable string for the last error returned by the
   * algorithm. The returned error will be one line and will not contain
   * any newline characters.
   *
   *
   * \param[in]    err     Error number.
   *
   */
  const char *vpx_codec_err_to_string(vpx_codec_err_t  err);


  /*!\brief Retrieve error synopsis for codec context
   *
   * Returns a human readable string for the last error returned by the
   * algorithm. The returned error will be one line and will not contain
   * any newline characters.
   *
   *
   * \param[in]    ctx     Pointer to this instance's context.
   *
   */
  const char *vpx_codec_error(vpx_codec_ctx_t  *ctx);


  /*!\brief Retrieve detailed error information for codec context
   *
   * Returns a human readable string providing detailed information about
   * the last error.
   *
   * \param[in]    ctx     Pointer to this instance's context.
   *
   * \retval NULL
   *     No detailed information is available.
   */
  const char *vpx_codec_error_detail(vpx_codec_ctx_t  *ctx);


  /* REQUIRED FUNCTIONS
   *
   * The following functions are required to be implemented for all codecs.
   * They represent the base case functionality expected of all codecs.
   */

  /*!\brief Destroy a codec instance
   *
   * Destroys a codec context, freeing any associated memory buffers.
   *
   * \param[in] ctx   Pointer to this instance's context
   *
   * \retval #VPX_CODEC_OK
   *     The codec algorithm initialized.
   * \retval #VPX_CODEC_MEM_ERROR
   *     Memory allocation failed.
   */
  vpx_codec_err_t vpx_codec_destroy(vpx_codec_ctx_t *ctx);


  /*!\brief Get the capabilities of an algorithm.
   *
   * Retrieves the capabilities bitfield from the algorithm's interface.
   *
   * \param[in] iface   Pointer to the algorithm interface
   *
   */
  //vpx_codec_caps_t vpx_codec_get_caps(vpx_codec_iface_t *iface);

}
