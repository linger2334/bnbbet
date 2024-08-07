import { ethers, run } from "hardhat";

async function main() {
  const ContractFactory = await ethers.getContractFactory("BNBbet");
  const contract = await ContractFactory.deploy();


  // Wait for the contract to be mined and get the contract's deployed bytecode
  await contract.waitForDeployment();

  console.log("Contract deployed to:",await contract.getAddress());

  // wait 1 minute for the contract to be mined
  await new Promise((r) => setTimeout(r, 60000));

  // Verify the contract
  try {
    await run("verify:verify", {
      address: await contract.getAddress(),
      constructorArguments: [],
    });
    console.log(`Contract verified successfully.`);
  } catch (error) {
    console.error("Failed to verify contract:", error);
  }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
