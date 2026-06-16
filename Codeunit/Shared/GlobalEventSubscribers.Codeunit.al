codeunit 50024 "Global Event Subscribers"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Page, Page::"Vendor List", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure FilterVendorsOnly(var Rec: Record Vendor)
    var

    begin
        Rec.Reset();
        Rec.SetRange("Vendor Type", Rec."Vendor Type"::Normal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeRunCheck', '', false, false)]
    local procedure OnBeforeRunCheck(var GenJournalLine: Record "Gen. Journal Line");
    begin
        with GenJournalLine do begin
            //if DocNoAlreadyPosted("Document No.") then;
            //  Error(DocNoAlreadyPostedMsg, "Document No.");
        end;
    end;

    local procedure DocNoAlreadyPosted(DocNo: Code[20]): Boolean
    var

    begin
        GLEntry.Reset();
        GLEntry.SetCurrentKey("Document No.", "Posting Date");
        GLEntry.SetRange("Document No.", DocNo);
        Exit(GLEntry.FindFirst());
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure ValidateOnDeleteCustomer(var Rec: Record Customer)
    begin
        // Rec.TestField("Customer Type", Rec."Customer Type"::Normal);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', false, false)]
    local procedure ValidateOnInsertCustomer(var Rec: Record Customer)
    begin
        // Rec.TestField("Customer Type", Rec."Customer Type"::Normal);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure ValidateOnDeleteVendor(var Rec: Record Vendor)
    begin
        Rec.TestField("Vendor Type", Rec."Vendor Type"::Normal);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', false, false)]
    local procedure ValidateOnBeforeInsertVendor(var Rec: Record Vendor)
    begin
        //  Rec.TestField("Vendor Type", Rec."Vendor Type"::Normal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure OnBeforeCustLedgEntryInsert(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        with GenJournalLine do begin
            CustLedgerEntry."Transaction Type Code" := GenJournalLine."Transaction Type Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure OnBeforeInsertDtldCustLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
        with GenJournalLine do begin
            DtldCustLedgEntry."Transaction Type Code" := GenJournalLine."Transaction Type Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeVendLedgEntryInsert', '', false, false)]
    local procedure OnBeforeVendLedgEntryInsert(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        with GenJournalLine do begin
            VendorLedgerEntry."Transaction Type Code" := GenJournalLine."Transaction Type Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure OnBeforeInsertDtldVendLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
        with GenJournalLine do begin
            DtldVendLedgEntry."Transaction Type Code" := GenJournalLine."Transaction Type Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(GenJournalLine: Record "Gen. Journal Line"; var GlobalGLEntry: Record "G/L Entry")
    begin
        with GenJournalLine do begin
            GlobalGLEntry."Transaction Type Code" := GenJournalLine."Transaction Type Code";
        end;
    end;

    var
        GLEntry: Record "G/L Entry";
        DocNoAlreadyPostedMsg: Label 'Document No. %1 is already posted';
}