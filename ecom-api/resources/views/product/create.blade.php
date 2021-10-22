@extends('layout')
@section('dashboard-content')
    <h1>Create Producto Form</h1>

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

    <form action="{{ URL::to('post-product-form')}}" method="post" enctype="multipart/form-data">
        @csrf
        <div class="form-group">
            <label for="exampleInputEmail1">Product Name</label>
            <input type="text" class="form-control mt-3"
             id="exampleInputEmail1" aria-describedby="emailHelp"
              placeholder="Enter product name" name="productName">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Product price</label>
            <input type="number" class="form-control mt-3"
             id="exampleInputEmail1" aria-describedby="emailHelp"  placeholder="0.0" name="productPrice">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Product discount</label>
            <input type="number" class="form-control mt-3" id="exampleInputEmail1" 
            aria-describedby="emailHelp"  placeholder="0.0" name="productDiscount">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Select a Post Category</label>
            <select  class="form-control"  name="category">
                <option>Select</option>
                    @foreach ($categories as $category)
                        <option value="{{$category->id}}">{{$category->name}}</option>
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
            <input type="checkbox" name="isHotProduct">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Is New Arrival </label>
            <input type="checkbox" name="isNewArrival">
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