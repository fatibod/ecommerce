@extends('layout')
@section('dashboard-content')
    <h1>Update Producto Form</h1>

    @if (Session::get('success'))
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="gone">
            <strong>{{ (Session::get('success')) }}</strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden=true>&times;</span>
            </button>
        </div>
    @endif

    @if (Session::get('failed'))
        <div class="alert alert-warning alert-dismissible fade show" role="alert" id="gone">
            <strong>{{ (Session::get('failed')) }}</strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden=true>&times;</span>
            </button>
        </div>
    @endif

    <form action="{{ URL::to('post-product-edit-form')}}/{{$product->id}}" method="post" enctype="multipart/form-data">
        @csrf
        <div class="form-group">
            <label for="exampleInputEmail1">Product Name</label>
            <input type="text" class="form-control mt-3"
             id="exampleInputEmail1" aria-describedby="emailHelp"
              placeholder="Enter product name" value="{{$product->name}}" name="productName">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Product price</label>
            <input type="text" class="form-control mt-3"
             id="exampleInputEmail1" aria-describedby="emailHelp" 
              placeholder="0.0"  value='{{$product->price}}' name="productPrice">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Product discount</label>
            <input type="text" class="form-control mt-3" id="exampleInputEmail1" 
            aria-describedby="emailHelp"  value="{{$product->discount}}" placeholder="0.0" name="productDiscount">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Select a Post Category</label>
            <select  class="form-control"  name="category">
                <option>Select</option>
                    @foreach ($categories as $category)
                        <option value="{{$category->id}}" @if($category->id == $product->category_id) selected @endif> {{$category->name}}</option>
                    @endforeach
            </select>
        </div>

        <div class="form-group">
            <label for="exampleInputEmail1">product photo</label>
            <input type="file" name="productPhoto" class="form-control"
             onChange="loadPhoto(event)">
        </div>
        <div class="form-group">
            <img id="photo" height="100" width="100" />
        </div>
        
        <div class="form-group">
            <label for="exampleInputEmail1">Is Hot Product </label>
            <input type="checkbox" name="isHotProduct" @if($product->is_hot_product > 0) checked @endif/>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Is New Arrival </label>
            <input type="checkbox" name="isNewArrival" @if($product->is_new_arrival > 0)checked @endif/>
        </div>
        
        <button type="submit" class="btn btn-primary mt-3">Submit</button>
    </form>

    <script>
        function LoadPhoto(event){
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('photo');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
@stop