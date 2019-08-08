## Zone Manager

## PreRequisites
- MySQL
- NodeJs
- Ruby
- ImageMagick

```
  # Mac OS
  brew install imagemagick

  # *NIX
  sudo apt-get install imagemagick libmagickwand-dev
```

> references - Select OS as necessary

  >- [Steps for installing Rails](https://gorails.com/setup/osx/10.13-high-sierra)
  
  >- [Steps for installing MySQL](https://dev.mysql.com/doc/refman/5.7/en/osx-installation-pkg.html)

## Installation

  1. Set up Backend

  ``` 
    bundle install
  ```

  2. Set up the app - 1st time
  
  ```
    rake db:seed
  ```

## Code Rules

- indents at 2 spaces
- Each module is with test cases and automated testing
- Each Pull request is in the form of a card name
  - Card 122 from trello with title "Fix all the X and Y in z" is being worked upon
  - branch name : 122-xy-fixes

- Release Cycle: After first beta (v0.1)
  - Each major with update at first decimal place - Eg: v0.2, v0.3, v0.4
  - each minor with update at 2 decimal places - Eg: v0.2.1 v0.2.2
  - each release to be noted on codebase as a tagged release

## API Documentation

(POSTman collection)[https://www.getpostman.com/collections/2f8feed6aba44576194b] with all APIs update per module

## Modules: (TBD)

### 1. Shared Modules

#### 1.1 Document Uploader and Image Uploader

Relates and accepts attributes from the parent model during creation/updation:

Add to your model:

```ruby
  class SomeModel < ApplicationRecord
    include Documented
    include Imaged
    ...
    ...
  end
```

Add to the controller for strong parameters:

```ruby
class SomeModelsController < ApplicationController
  ...
  ...

  private
    def some_model_params
      params.require(:some_model).permit(:place_id, :name, :desc, stored_file_whitelist, stored_image_whitelist) 
    end
end
```

Add to the form the necessary uploader interface

```erb
  # Only works if Imaged / Documented is included in the model
  <%= simple_nested_form_for(@model) do |f| %>
    <%= f.input :blah %>
    ...
    ...
    <%= render "shared/image_uploader", f: f %>
    <%= render "shared/document_uploader", f: f %>
  <% end %>
```

View will iterate over the elemtns and style them as necessary

```ruby
  @model.stored_files
  @model.stored_images
```

#### 1.2 Modal

To show any content in a modal, add to your view:

```html
  <%= render "shared/modal" %>
```

In the javascript:
```javascript
  $("#entityModalLabel").html("The Modal Title");
  $("#entityModalBody").html('<h4>THe modal HTML</h4><%= render "or_partial" %>');
  $("#entityModal").modal("show");
```

It is however recommended to use compiles JS for these operations found under assets/javascript

In case there is a dependency on erb, make a js.erb file and render 


#### 1.3 Pagination

Added in via custom library Paginator extending will_paginate

Add to your resource_controller:

```ruby
  @resources = Resource.paginate(page: params[:page], per_page: 10)
```

Add to the resource view:

```html
  <%= will_paginate @resources, renderer: WillPaginate::ActionView::BootstrapLinkRenderer %>
```

#### 1.3' Page Retention

To retain page and access it in an action - say after save or update, the page can be accessed with the following helpers:

In index, call the page handler to set current module page
```
  def index
    handle_pages
    ...
  end
```

Then in the action requiring redirect with page number:
```
  def update/create
    ...
      format.html { redirect_to module_path(page: prev_page), notice: 'Module was successfully created / updated' }
    ...
  end
```

#### 1.4 Suggesters

Two List suggesters exist in the system
1. Users Suggest
2. Places Suggest

>Usage: 
  In your form, where the user suggester is required:
  ```html
    <%= form_for(@model) do |f| %>
      <%= f.input :bla %>
      ...
      ...
      <%= render "shared/places_suggest", f: f %>    
      <%= render "shared/users_suggest", f: f %>    
    <% end %>
    ...
    ...
    <script type="text/javascript">
      // Set autosuggest on this module named model_name
      setPlaceSuggester("<%= places_suggest_path %>", "model_name_lowercase_singular");
      setUserSuggester("<%= users_suggest_path %>", "model_name_lowercase_singular");
    </script>
  ```

#### 1.5 Regional Language Field

Relates and accepts attributes from the parent model for regional name during creation/updation to add a regional name in addition to a module name

Add to your model:

```ruby
  class SomeModel < ApplicationRecord
    include Regional
    ...
    ...
  end
```

And to your controller whitelist: `regional_name_value`
```
class SomeModelsController < ApplicationController
  ...
  ...

  private
    def some_model_params
      params.require(:some_model).permit(:place_id, :name, :desc, :regional_name_value) 
    end
end
```


This inclusion will enable the following to @resource
```
  @resource.rgnl_name # -> {name} + {regional_name.name}
  @resource.regional_name_name # {regional_name.name}
```

basically allowing appending regional names to modules

>Dependency:
  > requires presence of a field called "name" in the parent model

### 2. Independent

#### 2.1 User

The actual Login Entity 
- Can log into the portal
- Can create Requests, View Data

Admin Role:
- Can create all data points

#### 2.2 Citizen

The Citizen Database composed of two classes of Citizen:
- Public
- Internal
These classes are managed in `Position` Module allowing creation of posts/occoupations

Each citizen has
- name
- phone number (validated)
- position
- place

### Known Bugs: Development

- Nested form in district creation has UI issues
