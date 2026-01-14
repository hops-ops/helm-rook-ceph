import models.io.crossplane.apiextensions.v1 as apiextensions

e2etest = apiextensions.E2ETest {
    metadata.name = "e2etest-rookceph"
    spec = {
        compositionPath = "../../apis/rookcephs/composition.yaml"
        xrdPath = "../../apis/rookcephs/definition.yaml"
        timeoutSeconds = 300
        skipDelete = False
        claimPath = "claim.yaml"
    }
}
