
# Run / Build containers-storage
nix run github:deng232/container-libs\
&nbsp;&nbsp;&nbsp;   build

# Usage
Usage: containers-storage command [options [...]]

Commands:

  check                         Check storage consistency
  config                        Print storage library configuration as JSON
  container                     Examine a container
  list-container-data           List data items that are attached to an container
  get-container-data            Get data that is attached to an container
  get-container-data-size       Get size of data that is attached to an container
  get-container-data-digest     Get digest of data that is attached to an container
  set-container-data            Set data that is attached to an container
  get-container-dir             Find the container's associated data directory
  get-container-run-dir         Find the container's associated runtime directory
  container-parent-owners       Compute the set of unmapped parent UIDs and GIDs of the container
  containers                    List containers
  copy                          Copy files or directories into a layer, possibly from another layer
  create-storage-layer          Create a new layer only in the storage driver
  create-layer                  Create a new layer
  import-layer                  Import a new layer
  create-image                  Create a new image using layers
  create-container              Create a new container from an image
  dedup                         Dedup all images
  delete                        Delete a layer or image or container, with no safety checks
  delete-layer                  Delete a layer, with safety checks
  delete-image                  Delete an image, with safety checks
  delete-container              Delete a container, with safety checks
  changes                       Compare two layers
  diffsize                      Compare two layers
  diff                          Compare two layers
  applydiff                     Apply a diff to a layer
  applydiff-using-staging-dir   Apply a diff to a layer using a staging directory
  exists                        Check if a layer or image or container exists
  gc                            Perform garbage collection
  image                         Examine an image
  list-image-data               List data items that are attached to an image
  get-image-data                Get data that is attached to an image
  get-image-data-size           Get size of data that is attached to an image
  get-image-data-digest         Get digest of data that is attached to an image
  set-image-data                Set data that is attached to an image (with sometimes wrong digest)
  get-image-dir                 Find the image's associated data directory
  get-image-run-dir             Find the image's associated runtime directory
  images                        List images
  images-by-digest              List images by digest
  layer                         Examine a layer
  layer-parent-owners           Compute the set of unmapped parent UIDs and GIDs of the layer
  list-layer-data               List data items that are attached to a layer
  get-layer-data                Get data that is attached to a layer
  set-layer-data                Set data that is attached to a layer
  layers                        List layers
  storage-layers                List storage layers
  metadata                      Retrieve layer, image, or container metadata
  set-metadata                  Set layer, image, or container metadata
  mount                         Mount a layer or container
  unmount                       Unmount an image, layer or container
  mounted                       Check if a file system is mounted
  get-names                     Get layer, image, or container name or names
  add-names                     Add layer, image, or container name or names
  remove-names                  Remove layer, image, or container name or names
  set-names                     Set layer, image, or container name or names
  shutdown                      Shut down layer storage
  status                        Check on graph driver status
  unshare                       Run a command in a user namespace
  version                       Return containers-storage version information
  wipe                          Wipe all layers, images, and containers

Options:

  --debug, -D             Print debugging information
  --graph, -g             Root of the storage tree
  --image-store           Root of the separate image store
  --run, -R               Root of the runtime state tree
  --storage-driver, -s    Storage driver to use ($STORAGE_DRIVER)
  --storage-opt=[]        Set storage driver options ($STORAGE_OPTS)
  --transient-store       Transient store
  --unshare, -U=true      Run in a user namespace (default true)

# container/container-libs

This repository is a **monorepo** combining several core Go libraries and utilities from the [containers](https://github.com/containers) project.  

It brings together:  

- **[`common`](./common/)** → Shared Go code and configuration used across multiple containers projects.  
- **[`storage`](./storage/)** → A Go library for managing container images, layers, and containers.  
- **[`image`](./image/)** → A Go library for interacting with container images and registries.  

These components are used by major container tools such as [Podman](https://github.com/containers/podman), [Buildah](https://github.com/containers/buildah), [CRI-O](https://github.com/cri-o/cri-o), and [Skopeo](https://github.com/containers/skopeo).


---

## Building

Each subproject has its own README.md file with more instructions.

## Contributing

We welcome contributions!

See the **[`CONTRIBUTING.md`](CONTRIBUTING.md)**, **[`CONTRIBUTING_GO.md`](CONTRIBUTING_GO.md)** and **[`CONTRIBUTING_RUST.md`](CONTRIBUTING_RUST.md)** files.

## Code of Conduct

See the **[`CODE-OF-CONDUCT.md`](CODE-OF-CONDUCT.md)** file.

## Security and Disclosure Information Policy

See the **[`SECURITY.md`](SECURITY.md)** file.


## License

- Apache License 2.0
- SPDX-License-Identifier: Apache-2.0
