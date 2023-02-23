public extension UICollectionView {
    
    /**
        Registers a class for use in creating new collection view cells using Generics and Protocols.
         - parameters:
         - with: _: CollectionViewCell to Register
         */
    func register<T: UICollectionViewCell>(with: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    /**
        Registers a nib file for use in creating new collection view cells using Generics and Protocols.
         - parameters:
         - _: CollectionViewCell to Register
         */
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

extension UICollectionViewCell: NibLoadableView { }

extension UICollectionViewCell: ReusableView { }
