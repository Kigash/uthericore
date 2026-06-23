codeunit 50028 "Reverse Savings Opening Bal"
{
    var
        GLEntry: Record "G/L Entry";
        ReversalEntry: Record "Reversal Entry";
        VendL: Record "Vendor Ledger Entry";
        Vendor: Record "Vendor";

    trigger OnRun()
    begin
        Vendor.Reset();
        Vendor.SetRange("Account Type", '03');
        if Vendor.FindSet() then begin
            repeat
                VendL.Reset();
                VendL.SetRange("Vendor No.", Vendor."No.");
                VendL.SetRange("Document No.", 'MIGRATION');
                VendL.SetRange(Reversed, false);
                If VendL.FindSet() then begin
                    repeat
                        GLEntry.Reset();
                        GLEntry.SetRange("Transaction No.", VendL."Transaction No.");
                        GLEntry.SetRange(Reversed, false);
                        if GLEntry.FindSet() then begin
                            repeat
                                ReversalEntry.SetHideWarningDialogs();
                                ReversalEntry.SetHideDialog(true);
                                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
                            until GLEntry.Next() = 0;
                        end;
                    until VendL.Next() = 0;
                end;
            until Vendor.Next() = 0;
        end;
    end;
}
